classdef DS2020A
    %DS2020A 使用VISA接口控制DS2020A的类
    %包含get和set两个类属性，DsGet用于从外设获取信息，DsSet用于设置外设
    
    properties(Access = public)
        vis    % 通信的接口
        Set    % 设置参数
        Get    % 获得信息
        %Analyze  % 数据分析
    end
    
    methods
        function obj = DS2020A(id)
           obj.vis = visa('NI', id);
           disp("--Successfully find the equiment.");            
           obj.Set = DsSet(obj);
           obj.Get = DsGet(obj);
        end
        
         function open(obj)
            %METHOD1 此处显示有关此方法的摘要
            fopen(obj.vis);    % Disconnect interface object from instrument
        end
        function close(obj)
            %METHOD1 此处显示有关此方法的摘要
            fclose(obj.vis);    % Disconnect interface object from instrument
            delete(obj.vis);    % Remove instrument objects from memory
        end
    end
end

