classdef Life < handle
    properties
        board
        size
        birthFromVoid
    end
    
    methods
        function obj = Life(w, h)
            obj.board = zeros(w, h);
            obj.size = [w, h];
            obj.birthFromVoid = 0;
        end
        
        function obj = fillRand(obj)
            rng();
            obj.board = randi(2, obj.size(1), obj.size(2)) - 1;
        end

        function obj = nextCycle(obj)
            for i = 1:obj.birthFromVoid
                obj.board(randi(obj.size(2)), randi(obj.size(1))) = 1;
            end
            prevBoard = obj.board;
            newBoard = obj.board;
            w = obj.size(1);
            h = obj.size(2);
            parfor y = 1:h
                for x = 1:w
                    neighbors = getNeighbors(prevBoard, x, y, w, h);
                    if (prevBoard(y, x) == 1 && (neighbors < 2 || neighbors > 3))
                        newBoard(y, x) = 0;
                    elseif (prevBoard(y, x) == 0 && neighbors == 3)
                        newBoard(y, x) = 1;
                    end
                end
            end
            obj.board = newBoard;
        end
    end
end

function neighbors = getNeighbors(board, x, y, w, h)
    yRange = max(y - 1, 1):min(y + 1, h);
    xRange = max(x - 1, 1):min(x + 1, w);
    neighbors = sum(board(yRange, xRange), [1, 2]);
    if (board(y, x) == 1)
        neighbors = neighbors - 1;
    end
end