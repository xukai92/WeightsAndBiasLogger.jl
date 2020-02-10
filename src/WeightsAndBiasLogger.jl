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

    function string_dict(prefix, config::Union{Dict,NamedTuple})
        prefix_with_delimiter = prefix == "" ? "" : "$prefix/"
        return Dict(prefix_with_delimiter * string(k) => config[k] for k in keys(config))
    end

    string_dict(config) = string_dict("", config)

    string_dict(config::Union{Dict,NamedTuple}; prefix="") = string_dict(prefix, config)

    string_dict(pairs::Iterators.Pairs; prefix="") = string_dict(preifx, Dict(pairs...))

    config!(wblogger::WBLogger, config) = wandb.config.update(string_dict(config))

    function config!(wblogger::WBLogger, pair::Pair)
        name, config = pair
        config!(wblogger, string_dict(config; prefix=name))
    end

    # AbstractLogger interface

    CoreLogging.catch_exceptions(lg::WBLogger) = false

    CoreLogging.min_enabled_level(lg::WBLogger) = lg.min_level

    CoreLogging.shouldlog(lg::WBLogger, level, _module, group, id) = true

    function CoreLogging.handle_message(lg::WBLogger, level, message, _module, group, id, file, line; commit=true, kwargs...)
        info_dict = Dict("$message/$k" => kwargs[k] for k in keys(kwargs))
        wandb.log(info_dict, commit=commit)
    end

    # Utilites

    with(f::Function, lg::AbstractLogger) = with_logger(f, lg)

    export wandb, WBLogger, config!, with
end # module
