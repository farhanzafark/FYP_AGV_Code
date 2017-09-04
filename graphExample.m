function H = graphExample()
n = 10; 
A = delsq(numgrid('L',n+2));
H = graph(A,'OmitSelfLoops');
plot(H)

% plot(H,'Layout','layered')
% plot(H,'Layout','circle')
% plot(H,'Layout','force')
%H.Nodes
%graphNodes = H.Nodes;
H.Nodes.Var1(1) = 1;
H.Nodes.Properties.VariableNames{1} = 'Node_Names';
for i = 1:75
H.Nodes.Node_Names(i) = i;
end
graphNodes = H.Nodes;
for i = 1:130
H.Edges.Weight(i) = 1;
end
H.numnodes

x = H.Edges.EndNodes;
H.neighbors(1);
H.neighbors(70);
randi(10,75);
H.Edges.Weight = randi(10,130,1);
p = plot(H,'Layout','force','EdgeLabel',H.Edges.Weight)
path1 = shortestpath(H,1,75);
path2 = shortestpath(H,1,58);
highlight(p,path2,'EdgeColor','r','LineWidth',1)
highlight(p,path1,'EdgeColor','g')
