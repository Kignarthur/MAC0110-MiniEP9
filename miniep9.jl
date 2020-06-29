# Add tests later
using LinearAlgebra
using Test


function matrix_pot(M, p)

    N = M

    for i in 2 : p
        M = multiplica(M,N)
    end

    return M

end

function multiplica(a, b)

    dima = size(a)
    dimb = size(b)

    if dima[2] != dimb[1]
        return -1
    end

    c = zeros(dima[1], dimb[2])

    for i in 1:dima[1]
        for j in 1:dimb[2]
            for k in 1:dima[2]
                c[i, j] = c[i, j] + a[i, k] * b[k, j]
            end
        end
    end

    return c
end

function matrix_pot_by_squaring(M, p)
    
    K = 1
    if p == 1
        K *= M
    elseif p % 2 == 0
        K *= matrix_pot_by_squaring(multiplica(M,M), p/2)
    elseif p % 2 != 0
        K *= M * matrix_pot_by_squaring(multiplica(M,M), (p-1)/2)
    end

    return K

end

function compare_times()

    size = 100
    p = 50
    M = rand( size, size )

    @time matrix_pot(M, p)
    @time matrix_pot_by_squaring(M, p)
end
