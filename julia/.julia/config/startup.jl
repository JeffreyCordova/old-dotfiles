atreplinit() do rel
    try
        @eval using OhMyREPL
        @eval colorscheme!("Base16MaterialDarker")
    catch e
        @warn "Error while importing OhMyREPL" e
    end
end

