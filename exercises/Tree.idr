
data Tree elem = Empty
               | Node (Tree elem) elem (Tree elem)

insert : Ord elem => elem -> Tree elem -> Tree elem
insert x Empty = Node Empty x Empty
insert x this@(Node treel y treer) =
      case compare x y of
           LT => Node (insert x treel) y treer
           EQ => this
           GT => Node treel y (insert x treer)
