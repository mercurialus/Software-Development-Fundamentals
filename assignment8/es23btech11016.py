def problem1(n:int,steps:int=0)->int:
    if n==1:
        return steps
    if n%2==0:
        return problem1(n/2,steps+1)
    elif n%2==1:
        return problem1(3*n+1,steps+1)

def reverse_line(name:string,):

