function [path,cost] = a_star(graph,start,goal)
%open list all unvisited nodes
%closed list evaluated nodes
%list 'f' of the cost of each node

p = plot(graph,'Layout','force','EdgeLabel',graph.Edges.Weight);

path = zeros(graph.numnodes,1);
openList = zeros(1,1);
openList(1,1) = start;
closedList = zeros(1);
closedListCount = 1;

cost_f = inf(graph.numnodes,1);
cost_f(start) = 0;
openList(1,2) = cost_f(start);
cost_g = inf(graph.numnodes,1);
cost_g(start) = 0;
cost_h = inf(graph.numnodes,1);

while ~isempty(openList)
   %find element in openList with minimum cost_f
   [M,I] = min(openList(:,2));
   
%    for i = 1:length(openList)
%       minimumNode = openList(i);
%       mimimumCostF = cost_f(minimumNode);
%       temp = cost_f(openList(i));
%       if temp < mimimumCostF 
%           mimimumCostF = temp
%           minimumNode = openList(i+1);
%       end
%    end
   
   q = openList(I,1);
%    I = find(openList==q);
   openList(I) = [];
   [m,n] = size(openList);
   if m == 1
       openList = zeros(1,2);
   end
   closedList(closedListCount) = q;
   closedListCount = closedListCount + 1;
   
   N = neighbors(graph,q);
   for i = 1:length(N)
      if N(i) == goal
          break;
      end
      
      if isempty(find(openList(:,1)==N(i), 1))
          if m == 1
              openList(m,:) = [N(i),cost_f(N(i))];
          else
              openList(m+1,:) = [N(i),cost_f(N(i))];
          end
      end
      tentative_gScore = cost_g(q) + distances(graph,q,N(i));
      if tentative_gScore >= cost_g(N(i))
          
      else
         path(N(i)) = q;
         cost_g(N(i)) = tentative_gScore;
         cost_f(N(i)) = cost_g(N(i))+ abs(p.XData(N(i))-p.XData(goal))+abs(p.YData(N(i))-p.YData(goal)); % + heuristic cost of neighbor 
         
         [elem,ind] = find(openList(:,1)==N(i));
         if ~isempty(ind)
             openList(ind,2) = cost_f(N(i));
         end
         
      end
      
   end
   
end
