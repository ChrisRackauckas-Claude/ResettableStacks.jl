__precompile__()

module ResettableStacks

    const FULL_RESET_COUNT = 10000

    using StaticArrays: StaticArray

    import Base: isempty, length, push!, pop!, iterate, eltype

    include("core.jl")

    using PrecompileTools: @compile_workload, @setup_workload

    @setup_workload begin
        @compile_workload begin
            stack = ResettableStack(Float64)
            push!(stack, 1.0)
            copyat_or_push!(stack, 2.0)
            collect(stack)
            pop!(stack)
            reset!(stack, true)
            isempty(stack)
        end
    end

    export ResettableStack, copyat_or_push!, reset!
end # module
