ourmap :: (a -> b) -> ([a] -> [b])
ourmap f (x:xs) = f x : ourmap f xs
ourmap _ []     = []


triple :: int -> int
triple n = n*3


sout(triple(1));
-> 3 
sout(triple(1.111));
-> 3.333

map triple [1,2,3]
map triple (1: [2,3]) = triple 1 : map triple [2,3]
map triple (2: [3])   = triple 1 : triple 2: map triple [3]
map triple (3: [])    = triple 1 : triple 2: triple 3 : map triple []
map _      []         = triple 1 : triple 2: triple 3 : [] = 3: 6: 9: []

 

number multiply(number a, number b){
    return a*b;
}


multiply :: Num a => a -> (a -> a)
multiply a b = a*b



triple = multiply 3

triple 5
15


































main = 
     do
        putStrLn "What is your Name"
        name :: IO String
        name <- getLn






-> [3,6,9]
[1,2,3] == 1: 2: 3: [] 





































Function<a[], b[]> map(Function<a,b> function) {
  return new Function
}


int maldrei (int a) {
    return 3*a;
}

int maldrei = ( int a ) => 3 * a;



map((int x => x*3), [1,2,3])