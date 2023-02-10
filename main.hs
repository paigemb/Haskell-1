-- Paige Biggs pmb66 
{------------------------------------Part 1: Haskell 
Functions------------------------------------------------------}
import Data.Char
{- Dot Product -}
dotproduct :: Num a => [a] -> [a] -> a 
dotproduct [] v1           = 0 --if there is an empty list return 0
dotproduct (h1:t1) (h2:t2) = h1 * h2 + dotproduct t1 t2 --else recursively add the 
products
{- My Map Helper Function-}
-- diy implemention of map
mymap f []    = []
mymap f (h:t) = f h : mymap f t
{- Vector Mult -}
vectormult v m
    | null (head m)  = [] --if the matrix is null, return the empty list 
    | otherwise      = dotproduct v (mymap head m) : vectormult v (mymap tail m) 
    -- else call dotproduct on the vectors and cons it with the recursive call on 
the rest of the vector 
{- Matrix Multiply -}
--matrixmultiply [] m2 = []
--matrixmultiply (h:t) m2 = vectormult h m2 : matrixmultiply t m2
matrixmultiply m1 m2 = mymap (`vectormult` m2) m1
-- uses mymap and vector mult as helper methods to multiply the matrices together
-- commented out code is the same functionality but using mymap simplified the 
logic
-- i left it because it is easier to understand 
{------------------------------------------Part 2: Haskell 
Types------------------------------------------------}
{- Bubble Down -}
data BinaryTree t = Empty | Leaf t | InnerNode t (BinaryTree t) (BinaryTree t) 
deriving (Show)
{-Helper method to extract the value of the node for comparison-}
getNode (Leaf a)              = a 
getNode (InnerNode a l r)     = a
{-Helper method to insert the node into the tree-}
add new (Leaf t)              = Leaf new
add new (InnerNode a l r)     = InnerNode new l r
bubbledown :: Ord t => BinaryTree t -> BinaryTree t
bubbledown Empty                                                      = Empty
bubbledown (Leaf a)                                                   = Leaf a
bubbledown (InnerNode a l r)
    -- if left is smaller than the right and root is greater than a child then swap
and recurse
    |(getNode l < getNode r) && ((a > getNode l) || (a > getNode r))  = InnerNode 
(getNode l) (bubbledown (add a l)) r
    -- if left is larger than the right and root is greater than a child then swap 
and recurse
    |(getNode l > getNode r) && ((a > getNode l) || (a > getNode r))  = InnerNode 
(getNode r) l (bubbledown (add a r))
    |otherwise                                                        = InnerNode a
l r
{- Create a type that allows us to have nested lists. Your type should have two 
kinds of values, elements and sublists. -}
data NestList l = Element l | SubList [NestList l] deriving(Show, Eq)
{- Flatten -}
-- remove all sublists and return a list with just elements 
--if element, cons it, recurse through rest and sulist
flatten []              = [] 
flatten ((Element h):t) = h : flatten t 
flatten ((SubList h):t) = flatten h ++ flatten t -- ++ appends
{- String to list -}
-- ideas: look for the closing paranthesis and use that to split the string
-- use the Data.char
{--------------------------------------- Part 3: Haskell 
Monads---------------------------------------------------------}
{- Your Function-}
{- The function takes a value of some type, 
a list of the same type (as a monad), and a test function and returns a list (in a 
monad). 
If the first passes the test (the test function on that element returns true), 
the element is appended to the monad list. Otherwise the result is Nothing -}
--yourfunction a mx f = do  -- Notes from TA 
 --   x <- mx
 --   if x == False then Nothing else return Just a : mx
 -- Only passes first two test cases
yourfunction :: Maybe a -> Maybe [a] -> (a -> Bool) -> Maybe [a]
yourfunction (Just a) (Just list) f
    |f a                             = Just (a : list)
    |otherwise                       = Nothing
{- checklist -}
checklist [] f = Just []
checklist l f = yourfunction (Just (head l)) (checklist (tail l) f) f
{- inorder from class-}
-- is_inorder [1,2,3,4]   => Just [1,2,3,4]
-- is_inorder [1,2,4,3]   => Nothing
-- Do this as a single recursive function doing one pass
{-is_inorder []    = Just []
is_inorder [a]   = Just [a]
is_inorder (a:(b:t)) 
    | a <= b    = (is_inorder (b:t)) >>= (\v -> return (a:v)) 
    | otherwise = Nothing -}
inorder [[]]                 = Just [[]]
inorder [[],[]]              = Just [[],[]]
inorder [[a]]                = Just  [[a]]
inorder ((h1:t1) : (h2:t2))
    | h1 <= h2               = (inorder (h2:t2)) >>= (\v -> return (h1:t1) )
    |otherwise               = Nothing
{- lreturn and lbind -}
data List t = Pair t (List t) | NoValue deriving (Show)
-- lengthened version would be lreturn a = Pair a, ommiting the variable 
lreturn = Pair 
lbind (Pair a l) f   =  f a (lbind l f)
lbind NoValue _      = NoValue --