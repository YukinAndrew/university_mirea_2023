"
Решить предыдущую задачу, но при условии наличия на поле простых
внутренних перегородок.
Под простыми перегородками мы понимаем изолированные
прямолинейные или прямоугольные перегородки
"

moves = Vector()

function check(robot, x, y)
    if ((abs(x + y)) % 2 == 0)
        putmarker!(robot)
    end
end

function go_back_i_want_to_be_monkey(robot)
    moves_revers = reverse(moves) 
    for i in moves_revers
        if i == Nord
            move!(robot, Sud)
        elseif i == Sud
            move!(robot, Nord)
        elseif i == Ost
            move!(robot, West)
        else
            move!(robot, Ost)
        end
    end
end

function snake!(robot, (move_side, next_row_side)::NTuple{2,HorizonSide}=(Ost, Nord))
    x = 0
    y = 0
    while !isborder(robot, West) || !isborder(robot, Sud)
        while !isborder(robot, West)
            x -= 1
            move!(robot, West)
            push!(moves, West)
        end
        while !isborder(robot, Sud)
            y -= 1
            move!(robot, Sud)
            push!(moves, Sud)
        end
    end
    check(robot, x, y)
    dir = move_side
    while (!isborder(robot, move_side) || !isborder(robot, next_row_side))
        flag = true
        while flag
            while isborder(robot, dir) && flag
                flag1 = true
                steps = 0
                while isborder(robot, dir)
                    if isborder(robot, next_row_side)
                        flag1 = false
                        break
                    else
                        steps += 1
                        y += 1
                        move!(robot, Nord)
                        push!(moves, Nord)
                        check(robot, x, y)
                    end
                end
                if flag1
                    while true
                        if dir == move_side x += 1
                        else x -= 1 end
                        move!(robot, dir)
                        push!(moves, dir)
                        check(robot, x, y)
                        if !isborder(robot, Sud) break end
                    end
                end
                while steps > 0
                    steps -= 1
                    y -= 1
                    move!(robot, Sud)
                    push!(moves, Sud)
                    check(robot, x, y)
                end
                if flag1 == false
                    flag = false
                end
            end
            if flag
                if dir == move_side
                    x += 1
                else
                    x -= 1
                end
                move!(robot, dir)
                push!(moves, dir)
                check(robot, x, y)
            end
        end
        if !isborder(robot, next_row_side)
            y += 1
            move!(robot, next_row_side)
            push!(moves, next_row_side)
            check(robot, x, y)
        end
        if dir == move_side
            dir = West
        else
            dir = move_side
        end
    end
    while !isborder(robot, West)
        x -= 1
        move!(robot, West)
        push!(moves, West)
        check(robot, x, y)
    end
    go_back_i_want_to_be_monkey(robot)
end
