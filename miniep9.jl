# Add tests later
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