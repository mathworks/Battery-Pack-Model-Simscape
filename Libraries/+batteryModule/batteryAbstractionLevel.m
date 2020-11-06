classdef batteryAbstractionLevel < int32
% Battery abstraction selection definition.
    
% Copyright 2020 The MathWorks, Inc.
    enumeration
        Lumped        (1)
        Detailed      (2)
    end

    methods(Static)
        function map = displayText()
            map = containers.Map;
            map('Lumped') = 'Lumped';
            map('Detailed') = 'Detailed';
        end
    end
end

