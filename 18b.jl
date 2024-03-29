"
б) некоторые из прямолинейных перегородок могут быть 
полубесконечными.
"

#stop_condition = ismarker
#stop_condition_2 = isborder
Sides = (Nord, Ost, Sud, West)


function shuttle!(stop_condition_2::Function, robot, id)
    k = 1
    state = true
    while stop_condition_2(r, Sides[id])
        for i in 1:k
            move!(robot, Sides[(id + 2) % 4 + 1])
        end
        if stop_condition_2(r, Sides[id])
            for i in 1:(k + 1)
                move!(robot, Sides[id % 4 + 1])
            end
        else 
            state = false
            break
        end
        k += 2
    end
    move!(robot, Sides[id])
    k /= 2
    while k >= (state ? 1 : 0)
        k -= 1
        state ? move!(robot, Sides[(id + 2) % 4 + 1]) : move!(robot, Sides[id % 4 + 1]) 
    end
end

function along!(stop_condition::Function, robot, id, k)
    for i in 1:k
        if stop_condition(robot) return end
        if isborder(robot, Sides[id])
            shuttle!(isborder, r, id)
        else 
            move!(robot, Sides[id])
        end
    end
end

function spiral!(stop_condition::Function, robot)
    k = 1
    while !stop_condition(robot)
        along!(stop_condition, robot, 1, k)
        along!(stop_condition, robot, 2, k)
        along!(stop_condition, robot, 3, k + 1)
        along!(stop_condition, robot, 4, k + 1)
        k += 2
    end
end
