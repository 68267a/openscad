<!-- https://old.reddit.com/r/rubikscube/comments/ot13nb/3x3_mnemonic_algorithm/ -->
# List of Rubik's Cube Algorithms 3x3
These are the algorithms that are necessary to solve the Rubik's Cube and the step in the process where they are used. For more detailed information on where and when to use these algorithms, see below.

Notation | Word | Reverse Notation | Word
-|-|-|-
F  | Front | F' | Fast
R  | Right | R' | Run
L  | Left  | L' | Lift
U  | Up    | U' | Oop
D  | Down  | D' | Dig
B  | Back  | B' | Butt

Becomes

Step | Description | Algorithm
-|-|-
1 | white cross                 | R' U R U' R'
| | | *Run Up Right Oop Run* 
2 | white corners               | R' D' R D
| | | *Run Dig Right Down* 
3a| middle layer edges to left  | U' L' U L U F U' F'
| | | *Oop Lift Up Left Up Front Oop Fast* 
3b| middle layer edges to right | U R U' R' U' F' U F
| | | *Up Right Oop Run Oop Fast Up Front* 
4a | yellow cross dot to "L"     | F R U R' U' F'
| | | *Front Right Up Run Oop Fast* 
4b | yellow cross "L" to line    | F U R U' R' F'
| | | *Front Up Right Oop Run Fast* 
4c | yellow cross line to cross  | F R U R' U' F'
| | | *Front Right Up Run Oop Fast* 
5a | Only one yellow corner      | R U R' U R UU R'
| | | *Right Up Run Up Right Up Up Run* 
5b | Sune and Antisune (corners) | UU R UU R' U' R U' R'
| | | *Up Up Right Up Up Run Oop Right Oop Run* 
6a | Headlights                  | R' F R' BB R F' R' BB RR
| | | *Run Front Run Back Back Right Fast Run Back Back Right Right* 
6b | U permutation (solved bar)  | R U' R U R U R U' R' U' RR
| | | *Right Oop Right Up Right Up Right Oop Run Oop Right Right* 
