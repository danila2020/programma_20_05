#= задача 6 
Задача 6. Написать функцию, получающую на вход имя некоторого типа (встоенного или пользовательского) языка Julia (тип этого аргумента - Type)
 и распечатывающая список всех дочерних типов в следующем формате:
 Этот формат показан условно: число иерархических уровней в действилельности может быть любым другим, 
 и число подтипов на каждом уровне тоже может быть каким угодно.=#
function  disp_type_tree(type::Type, shift=0)
    println(join([" "^shift, type]))
    shift+=4
    for st in subtypes(type)
        disp_type_tree(st, shift)
    end
end
 
disp_type_tree(Real)
# задача 7
function find_general(tree::Vector, setver::Set)
 
    ConnectList = 0
    index_root = 0
    number_visited = 0 # - cчетчик числа посещённых вершин из набора setver
    general = 0 # - в этой переменной формируется результат (начальное значение не должно только входить в диапазон индексов вершин дерева)
 
    function recurstrace(a,tree, parent=0) # - выполняет рекурсивную обработку дерева сверху-вниз      
        is_mutable_general = false # при движение по дереву вглубь от корня внешнюю переменную general изменять не надо 
 
        for subtree in tree[begin:end-1]
            if number_visited < length(setver)
                recurstrace(subtree, tree[end])
            end
        end
 
        for ConnectList in range 1:length(a)
            return a[i]
        end
 
        # number_visited = число ранее посещенных вершин из заданного набора setver
        if tree[end] in setver
            number_visited +=1
            if number_visited == 1
                general = tree[end]
            end                        
        end
        # теперь - обратное движение по дереву - из глубины к корню
        if general==tree[end] 
            is_mutable_general = true # т.е. при движении к корню, внешнюю переменную general снова нужно отслеживать
        end
        if is_mutable_general && number_visited < length(setver)
            general = parent
        end
 
println((current=tree[end],parent=parent,general=general)) # - это для отладки
    end
 
    recurstrace(tree)
    return general
end
 
#-------------- TEST: -----------
 
tree=[[[[4],[5],[6],3],[[9],[[[17],[18],16],[19],10],7],2],[[11],[[14],[15],12],8],1]
#find_general(tree,Set((3,4,6,7))) |> println # 2
find_general(tree,Set((6,10,16))) |> println # 2
 
# задача 1
ConnectList{T}=Vector{Vector{T}}
NestedVectors = Vector
 
function convert_to_nested(tree::ConnectList{T},root::T) where T
    nested_tree = []
    for subroot in tree[root]
        push!(nested_tree, convert(tree, subroot))
    end
    push!(nested_tree, root)
    return nested_tree
end
 
#---------ТЕСТ:
tree=[[2,3],
      [],
      [4,5],
      [],
      []]
 
nested_tree = convert_to_nested(tree, 1) 
println(nested_tree)  # Any[Any[2], Any[Any[4], Any[5], 3], 1] 