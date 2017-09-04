function [dist,previous] = dijkstra(graph,source)
p = plot(graph,'Layout','force','EdgeLabel',graph.Edges.Weight);
%visitedNodes = inf(graph.numnodes,1);
%unVisitedNodes = graph.Nodes.Node_Names;
unVisitedNodes(:,1) = graph.Nodes.Node_Names;
dist = inf(graph.numnodes,1);
dist(source) = 0;
unVisitedNodes(:,2) = dist;
previous = zeros(graph.numnodes,1);

    while ~isempty(unVisitedNodes) %length(unVisitedNodes)~=0
    [M,I] = min(unVisitedNodes(:,2));
%     
%     if I > length(unVisitedNodes)
%         I = length(unVisitedNodes);
%     end
    u = unVisitedNodes(I,1);
   
    N = neighbors(graph,u);
        for i = 1:length(N)
            v = find(graph.Nodes.Node_Names==N(i));
            indexNeighbor = find(unVisitedNodes(:,1)==v);
            %alt = dist(u) + distances(graph,u,N(i));
            alt = dist(u) + distances(graph,u,N(i));
            if alt < unVisitedNodes(indexNeighbor,2)
               unVisitedNodes(indexNeighbor,2) = alt;
               dist(v) = alt;
               previous(v) = u;
            end
        end
        unVisitedNodes(I,:) = [];
    end
    %return dist,previous;
end