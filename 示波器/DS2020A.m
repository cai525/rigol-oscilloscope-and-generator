classdef DS2020A
    %DS2020A ʹ��VISA�ӿڿ���DS2020A����
    %����get��set���������ԣ�DsGet���ڴ������ȡ��Ϣ��DsSet������������
    
    properties(Access = public)
        vis    % ͨ�ŵĽӿ�
        Set    % ���ò���
        Get    % �����Ϣ
        %Analyze  % ���ݷ���
    end
    
    methods
        function obj = DS2020A(id)
           obj.vis = visa('NI', id);
           disp("--Successfully find the equiment.");            
           obj.Set = DsSet(obj);
           obj.Get = DsGet(obj);
        end
        
         function open(obj)
            %METHOD1 �˴���ʾ�йش˷�����ժҪ
            fopen(obj.vis);    % Disconnect interface object from instrument
        end
        function close(obj)
            %METHOD1 �˴���ʾ�йش˷�����ժҪ
            fclose(obj.vis);    % Disconnect interface object from instrument
            delete(obj.vis);    % Remove instrument objects from memory
        end
    end
end

