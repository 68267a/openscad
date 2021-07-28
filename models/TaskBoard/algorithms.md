<!-- https://old.reddit.com/r/rubikscube/comments/ot13nb/3x3_mnemonic_algorithm/ -->
# List of Rubik's Cube Algorithms 3x3
These are the algorithms that are necessary to solve the Rubik's Cube and the step in the process where they are used. For more detailed information on where and when to use these algorithms, see below.

Notation | Word | Reverse Notation | Word
-|-|-|-
F  | Front | F' | Fast
R  | Right | R' | Run
L  | Left  | L' | Last
U  | Up    | U' | Oop
D  | Down  | D' | Dig
B  | Back  | B' | Butt

Becomes

- | Step | Algorithm
-|-|-
1 | white cross                 | R' U R U' R'
| | | _Run Up Right Oop Run_ 
2 | white corners               | R' D' R D
| | | _Run Dig Right Down_ 
3a| middle layer edges to left  | U' L' U L U F U' F'
| | | _Oop Last Up Left Up Front Oop Fast_ 
3b| middle layer edges to right | U R U' R' U' F' U F
| | | _Up Right Oop Run Oop Fast Up Front_ 
4a | yellow cross dot            | F R U R' U' F'
| | | _Front Right Up Run Oop Fast_ 
4b | yellow cross "L"            | F U R U' R' F'
| | | _Front Up Right Oop Run Fast_ 
4c | yellow cross line           | F R U R' U' F'
| | | _Front Right Up Run Oop Fast_ 
5a | Only one yellow corner      | R U R' U R UU R'
| | | _Right Up Run Up Right Up Up Run_ 
5b | Sune and Antisune (corners) | UU R UU R' U' R U' R'
| | | _Up Up Right Up Up Run Oop Right Oop Run_ 
6a | Headlights                  | R' F R' BB R F' R' BB RR
| | | _Run Front Run Back Back Right Fast Run Back Back Right Right_ 
6b | U permutation (solved bar)  | R U' R U R U R U' R' U' RR
| | | _Right Oop Right Up Right Up Right Oop Run Oop Right Right_ 
