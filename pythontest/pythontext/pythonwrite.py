file_path = 'paragramming.txt'

# with open(file_path,'w') as file_object1:
#     file_object1.write('I like python.\nI also like java .\n ')
# with open(file_path, 'r') as file_object1:
#     content = file_object1.read()
#     print(content.rstrip())



with open(file_path,'a+') as file_object2:
    file_object2.write('I like RF.\nalso i like pytest.\n')
    content = file_object2.read()
    print(content.rstrip())




