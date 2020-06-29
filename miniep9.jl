# Add tests later
using LinearAlgebra
using Test

function testMtxPot()
    Ma = [ 4  3  4; 9  5  1 ; 3  4  2]
    Mb = [ 7   8  8   0; 13   4  5  11; 10   0  8   5; 3  13  4   3]
    Mc = [1   6   7   5   4; 5  10   0   6   6; 8   0  12  12  10; 
    2  11   5   4  11; 6   7  10   5   6]
    Md = [16  18; 15  14]
    for i in 1 : 100000
        P = rand(1:10)
        @test matrix_pot(Ma,P) == Ma^P
        @test matrix_pot(Mb,P) == Mb^P
        @test matrix_pot(Mc,P) == Mc^P
        @test matrix_pot(Md,P) == Md^P
    end
    println("OK")
end

function testMtxPotSqr()
    Ma = [ 4  3  4; 9  5  1 ; 3  4  2]
    Mb = [ 7   8  8   0; 13   4  5  11; 10   0  8   5; 3  13  4   3]
    Mc = [1   6   7   5   4; 5  10   0   6   6; 8   0  12  12  10; 
    2  11   5   4  11; 6   7  10   5   6]
    Md = [16  18; 15  14]
    for i in 1 : 100000
        P = rand(1:10)
        @test matrix_pot_by_squaring(Ma,P) == Ma^P
        @test matrix_pot_by_squaring(Mb,P) == Mb^P
        @test matrix_pot_by_squaring(Mc,P) == Mc^P
        @test matrix_pot_by_squaring(Md,P) == Md^P
    end
    println("OK")
    
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

function matrix_pot(M, p)

    N = M

    for i in 2 : p
        M = multiplica(M,N)
    end

    return M

end

testMtxPot()

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

testMtxPotSqr()

function compare_times()

    size = 100
    p = 50
    M = rand( size, size )

    @time matrix_pot(M, p)
    @time matrix_pot_by_squaring(M, p)
end
