"
Написать рекурсивную функцию, перемещающую робота на расстояние 
вдвое большее исходного расстояния от перегородки, находящейся с заданного 
направления (предполагается, что размеры поля позволяют это сделать).
"

using HorizonSideRobots
include("functions.jl")

r = Robot("untitled22.1.sit", animate = true)

"""twice dist - вдвое удалённый"""
function twicedist!(robot, side)
    if !isborder(robot, side)
        move!(robot, side)
        twicedist!(robot, side)
        if numsteps_along!(robot, inverse(side), 2) != 2
            return false
        end
    end
    return true
end


twicedist!(r, Ost)
