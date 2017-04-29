module BSTree

public export
data BSTree : Type -> Type where
     Empty : Ord elem => BSTree elem
     Node : Ord elem => (left : BSTree elem) -> (val : elem) ->
                        (right : BSTree elem) -> BSTree elem

public export
insert : Ord elem => elem -> BSTree elem -> BSTree elem
insert x Empty = Node Empty x Empty
insert x this@(Node treel e treer) = case compare x e of
          LT => Node (insert x treel) e treer
          EQ => this
          GT => Node treel e (insert x treer)
