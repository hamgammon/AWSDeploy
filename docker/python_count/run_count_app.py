import os
if not os.path.exists('log.txt'):
    with open('log.txt','w') as f:
        f.write('0')
with open('log.txt','r') as f:
    st = int(f.read())
    st+=1 
with open('log.txt','w') as f:
    f.write(str(st))
print(f'Ran {st} times')