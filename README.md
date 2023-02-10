# Haskell-1
For many of the functions below, you are to welcome use helper functions. Your goal is to make the coding logic as simple as you can.

Part 1: Haskell Functions

1. dotproduct takes a two vectors (lists of numbers) and computes the dot product of the vectors. If one list is longer than the other, you can ignore the extra numbers of the longer list.

2. vectormult takes a row vector (a list of numbers) and matrix (a list of lists of numbers) and multiplies the vector times the matrix. The result is a vector where the ith element of the result is the dotproduct of the input vector and the ith column of the matrix. You can assume that the length of the vector matches the number of rows of the matrix.

3. matrixmultiply takes two matrices (a list of lists of numbers) and multiplies them. You can assume the number of columns of the first matrix is equal to the number of rows of the second matrix.
in the same sublist

Part 2: Haskell Types

4. Using the BinaryTree type created in class (use a version without lists), write a function bubbledown that takes a BinaryTree as input. If the element stored in the root is larger than either children, swap the element with the smaller child, and recurse on the child you swapped the element with. The recursion should stop when either you reach a leaf or when the element of the node is smaller than both its children.

5. While Haskell is similar to Scheme, Haskell's type rules prevent us from writing a function like the *-functions of the first Scheme homework. For example, we can't write the equivalent of (reverse* '(1 2 3 4 5 (1 ((5 3) ())) 1 6 2)) because a list can't contain both int types and list types as elements. You will fix this by creating the following type.

Create a type that allows us to have nested lists. Your type should have two kinds of values, elements and sublists. For example, the following will be a valid list: [Element 1,Element 3,SubList [Element 4,SubList [SubList [Element 5],SubList []]],Element 6]

6. Create the function flatten that takes a list as above and returns a list with just the elements.

7. Create the function string2list that takes a string containing single digits and parentheses (possibly spaces or commas) and create a list.

Part 3: Haskell Monads


8. Using the Maybe monad of Haskell, create a function that has the following type:

yourfunction :: a -> Maybe [a] -> (a -> Bool) -> Maybe [a]

The function takes a value of some type, a list of the same type (as a monad), and a test function and returns a list (in a monad). If the first passes the test (the test function on that element returns true), the element is appended to the monad list. Otherwise the result is Nothing.

Using your above function, create a function checklist that takes a list and a function and returns Nothing if the elements in the list fail to past the function and the list (embedded in a Maybe) if all the elements pass.

9. Create the function inorder that takes a list that contains lists of numbers and returns a Maybe containing the list if all the numbers in the sublists are in non-decreasing order from left to right, and it should return Nothing if the numbers are not in non-decreasing order. You are allowed to have helper functions, but the total computation should do a single traversal of the data in the list.

10. In Haskell, lists are monads. For example, [1,2,3] >>= (\v -> [2*v]) produces the list [2,3,4]. In this problem, you are to figure out how that works.

Create a list monad that generalizes a list. This will not be a Haskell Monad type, but instead one of our own creation like the Value type from lecture. For example, the following is a valid "list". Then create a binding function lbind and a return function lreturn to make a list monad. The code should work so that

