module WeightsAndBiasLogger
    using PyCall
    const wandb = PyNULL()

    function __init__()
        copy!(wandb, pyimport("wandb"))
    end

    using Base.CoreLogging: CoreLogging, AbstractLogger, LogLevel, Info, handle_message, shouldlog, min_enabled_level, catch_exceptions, with_logger

    mutable struct WBLogger <: AbstractLogger
        min_level::LogLevel
    end

    function WBLogger(; min_level::LogLevel=Info, reinit=true, init_args...)
        wandb.init(; reinit=reinit, init_args...)
        return WBLogger(min_level)
    end

    function string_dict(prefix, cfg, ignores)
        ignores = string.(ignores)
        # Make string dict
        dict = Dict(string(k) => cfg[k] for k in keys(cfg))
        # Ignore some keys
        dict = filter(p -> !(string(p.first) in ignores), dict)
        # Add prefix
        dict = Dict(prefix * k => dict[k] for k in keys(dict))
        return dict
    end

    config!(wblogger::WBLogger, p::Pair; kwargs...) = config!(wblogger, p.first, p.second; kwargs...)
    config!(wblogger::WBLogger, cfg; kwargs...) = config!(wblogger, "", cfg; kwargs...)
    function config!(wblogger::WBLogger, name::String, cfg; ignores=[])
        prefix = name == "" ? "" : "$name/"
        wandb.config.update(string_dict(prefix, cfg, ignores))
    end

    # AbstractLogger interface

    CoreLogging.catch_exceptions(lg::WBLogger) = false

    CoreLogging.min_enabled_level(lg::WBLogger) = lg.min_level

    CoreLogging.shouldlog(lg::WBLogger, level, _module, group, id) = true

    function CoreLogging.handle_message(lg::WBLogger, level, message, _module, group, id, file, line; commit=true, kwargs...)
        prefix = message == "" ? "" : "/"
        info_dict = Dict("$prefix/$k" => kwargs[k] for k in keys(kwargs))
        wandb.log(info_dict, commit=commit)
    end

    # Utilites

    with(f::Function, lg::AbstractLogger) = with_logger(f, lg)

    export wandb, WBLogger, config!, with
end # module
