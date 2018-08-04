from collections import deque
list1 = [1,2,3,4,5]
list = deque(list1)
list2 = [6,7]
list.extendleft(list2)
print(list)