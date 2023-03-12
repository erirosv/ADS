"""
DIT374 
"""

import random;

RED = 1;
BLACK = 0;

class Node():
    def __init__(self, val):
        self.val = val;
        self.color = RED;
        self.parent = None;
        self.left = None;
        self.right = None;

class RBTree():

    def __init__(self):
        self.NullNode = Node(0);

        self.NullNode.color = BLACK;
        self.NullNode.left = None;
        self.NullNode.right = None;

        self.root = self.NullNode;


    def add(self, key):
        newNode = Node(key);
        
        newNode.parent = None;
        newNode.left = self.NullNode;
        newNode.right = self.NullNode;
        newNode.color = RED;

        tempA = None;
        tempB = self.root;

        while tempB != self.NullNode:
            tempA = tempB;
            if newNode.val < tempB.val:
                tempB = tempB.left;
            else:
                tempB = tempB.right;

        newNode.parent = tempA;

        if tempA == None:
            self.root = newNode;
        elif newNode.val < tempA.val:
            tempA.left = newNode;
        else:
            tempA.right = newNode;

        if newNode.parent == None:
            newNode.color = BLACK;
            return;

        if newNode.parent.parent == None:
            return;

        while newNode.parent.color == RED:
            if newNode.parent == newNode.parent.parent.right:
                tempC = newNode.parent.parent.left;

                if tempC.color == RED:
                    tempC.color = BLACK;

                    newNode.parent.color = BLACK;
                    newNode.parent.parent.color = RED;

                    newNode = newNode.parent.parent;
                else:
                    if newNode == newNode.parent.left:
                        newNode = newNode.parent;

                        self.rotR(newNode);
                    
                    newNode.parent.color = BLACK;
                    newNode.parent.parent.color = RED;

                    self.rotL(newNode.parent.parent);
            else:
                tempC = newNode.parent.parent.right;

                if tempC.color == RED:
                    tempC.color = BLACK;
                    
                    newNode.parent.color = BLACK;
                    newNode.parent.parent.color = RED;
                    
                    newNode = newNode.parent.parent;
                else:
                    if newNode == newNode.parent.right:
                        newNode = newNode.parent;
                        
                        self.rotL(newNode)
                    
                    newNode.parent.color = BLACK;
                    
                    newNode.parent.parent.color = RED;
                    
                    self.rotR(newNode.parent.parent);
            if newNode == self.root:
                break;
        self.root.color = BLACK;


    def delete(self, key):
        node = self.root;

        removeNode = self.NullNode;

        while node != self.NullNode:
            if node.val == key:
                removeNode = node;

            if node.val <= key:
                node = node.right;
            else:
                node = node.left;

        tempA = removeNode;
        tempAColor = tempA.color;

        if removeNode.left == self.NullNode:
            tempB = removeNode.right;
            self.swapNodes(removeNode, removeNode.right);
        elif removeNode.right == self.NullNode:
            tempB = removeNode.left;
            self.swapNodes(removeNode, removeNode.left);
        else:
            tempA = self.min(removeNode.right);
            tempAColor = tempA.color;
            tempB = tempA.right;

            if tempA.parent == removeNode:
                tempB.parent = tempA;
            else:
                self.swapNodes(tempA, tempA.right);
                tempA.right = removeNode.right;
                tempA.right.parent = tempA;

            self.swapNodes(removeNode, tempA);

            tempA.left = removeNode.left;
            tempA.left.parent = tempA;
            tempA.color = removeNode.color;

        if tempAColor == BLACK:
            while True:
                
                if tempB.color != BLACK:
                    break;
                if tempB == self.root:
                    break;
                
                if tempB == tempB.parent.left:
                    tempC = tempB.parent.right;

                    if tempC.color == RED:
                        tempC.color = BLACK;
                        tempB.parent.color = RED;

                        self.rotL(tempB.parent);

                        tempC = tempB.parent.right;

                    if tempC.left.color == BLACK and tempC.right.color == BLACK:
                        tempC.color = RED;
                        tempB = tempB.parent;
                    else:
                        if tempC.right.color == BLACK:
                            tempC.left.color = BLACK;
                            tempC.color = RED;
                            
                            self.rotR(tempC);
                            
                            tempC = tempB.parent.right;

                        tempC.color = tempB.parent.color;
                        tempB.parent.color = BLACK;
                        tempC.right.color = BLACK;
                        
                        self.rotL(tempB.parent);

                        tempB = self.root;
                else:
                    tempC = tempB.parent.left;

                    if tempC.color == RED:
                        tempC.color = BLACK;
                        tempB.parent.color = RED;
                        
                        self.rotR(tempB.parent);

                        tempC = tempB.parent.left;

                    if tempC.right.color == BLACK and tempC.right.color == BLACK:
                        tempC.color = RED;
                        tempB = tempB.parent;
                    else:
                        if tempC.left.color == BLACK:
                            tempC.right.color = BLACK;
                            tempC.color = RED;
                            
                            self.rotL(tempC);

                            tempC = tempB.parent.left;

                        tempC.color = tempB.parent.color;
                        tempB.parent.color = BLACK;
                        tempC.left.color = BLACK;
                        
                        self.rotR(tempB.parent);
                        
                        tempB = self.root;

            tempB.color = BLACK;


    def swapNodes(self, nodeA, nodeB):
        if nodeA.parent == None:
            self.root = nodeB;
        elif nodeA == nodeA.parent.left:
            nodeA.parent.left = nodeB;
        else:
            nodeA.parent.right = nodeB;
        
        nodeB.parent = nodeA.parent;

    def showR(self, node, head, r):
        if node == self.NullNode or node == None:
            return;
        
        s = head;

        if r:
            s += "R---";
            head += "    ";
        else:
            s += "L---";
            head += "|   ";

        s += str(node.val);
        s += "(";
        s += "RED" if node.color == RED else "BLACK";
        s += ")";

        print(s);

        self.showR(node.left, head, False);
        self.showR(node.right, head, True);

    def min(self, node):
        while node.left != self.NullNode:
            node = node.left;

        return node

    def max(self, node):
        while node.right != self.NullNode:
            node = node.right;

        return node

    def rotR(self, node):
        otherNode = node.left;
        node.left = otherNode.right;

        if otherNode.right != self.NullNode:
            otherNode.right.parent = node;

        otherNode.parent = node.parent

        if node.parent == None:
            self.root = otherNode;
        elif node == node.parent.right:
            node.parent.right = otherNode;
        else:
            node.parent.left = otherNode;
        
        otherNode.right = node;
        node.parent = otherNode;

    def rotL(self, node):
        otherNode = node.right;
        node.right = otherNode.left;

        if otherNode.left != self.NullNode:
            otherNode.left.parent = node;

        otherNode.parent = node.parent;

        if node.parent == None:
            self.root = otherNode;
        elif node == node.parent.left:
            node.parent.left = otherNode;
        else:
            node.parent.right = otherNode;
        
        otherNode.left = node;
        node.parent = otherNode;

    def valuesAscendingR(self, node, l):
        if node != self.NullNode:
            self.valuesAscendingR(node.left, l)
            l.append(node.val);
            self.valuesAscendingR(node.right, l)

    def valuesAscending(self):
        l = [];
        self.valuesAscendingR(self.root, l);
        
        return l;

    def show(self):
        self.showR(self.root, "", True)

def merge(treeA, treeB, f):
    r = RBTree();
    r.root = Node(-1);
    mergeR(r.root, treeA.root, treeB.root, f);

    return r;

def mergeR(nodeR, nodeA, nodeB, f):
    nodeR.val = f(nodeA.val, nodeB.val);


    if nodeA.right != None and nodeA.right.parent != None:
        nodeR.right = Node(-1);
        nodeR.right.parent = nodeR;
        mergeR(nodeR.right, nodeA.right, nodeB.right, f);

    if nodeA.left != None and nodeA.left.parent != None:
        nodeR.left = Node(-1);
        nodeR.left.parent = nodeR;
        mergeR(nodeR.left, nodeA.left, nodeB.left, f);

def chainMerge(l, f):
    c = l[0];
    for i in range(1, len(l)):
        c = merge(c, l[i], f);
    return c;

def union(t1, t2, x):
    r = RBTree();
    
    for v in t1.valuesAscending():
        r.add(v);
    
    for v in t2.valuesAscending():
        r.add(v);

    r.add(x);

    return r;

l1 = list(range(20));
random.shuffle(l1);
tree1 = RBTree();
for i in l1:
    tree1.add(i);
# This should show a tree populated with [0, 20].
tree1.show();

tree1.delete(4);
# This should show a tree populated with [0, 3] U [5, 20].
tree1.show();

# If it terminates it scales.
l2 = list(range(1000000));
random.shuffle(l2);
tree2 = RBTree()
for i in l2:
    tree2.add(i);

for d in range(1000):
    tree2.delete(d);
