module WeightsAndBiasLogger
    using PyCall
    const wandb = PyNULL()

    function __init__()
        copy!(wandb, pyimport("wandb"))
    end

    using Base.CoreLogging: CoreLogging, AbstractLogger, LogLevel, Info, handle_message, shouldlog, min_enabled_level, catch_exceptions

    mutable struct WBLogger <: AbstractLogger
        min_level::LogLevel
    end

    function WBLogger(; min_level::LogLevel=Info, reinit=true, init_args...)
        wandb.init(; reinit=reinit, init_args...)
        return WBLogger(min_level)
    end

    function string_dict(dict::Union{Dict,NamedTuple})
        return Dict(string(k) => dict[k] for k in keys(dict))
    end

    string_dict(dict::Dict{String,<:Any}) = dict

    string_dict(pairs::Iterators.Pairs) = string_dict(Dict(pairs...))

    config!(wblogger::WBLogger, config) = wandb.config.update(string_dict(config))

    # AbstractLogger interface

    CoreLogging.catch_exceptions(lg::WBLogger) = false

    CoreLogging.min_enabled_level(lg::WBLogger) = lg.min_level

    CoreLogging.shouldlog(lg::WBLogger, level, _module, group, id) = true

    function CoreLogging.handle_message(lg::WBLogger, level, message, _module, group, id, file, line; commit=true, kwargs...)
        info_dict = Dict("$message/$k" => kwargs[k] for k in keys(kwargs))
        wandb.log(info_dict, commit=commit)
    end

    export wandb, WBLogger, config!
end # module
