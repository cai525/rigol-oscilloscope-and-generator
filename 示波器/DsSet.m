classdef DsSet
    %DSSET: DS2020A�����࣬��������������ĸ��ֲ��� 
    properties
        visSet 
    end
    
    methods
        function obj = DsSet(ds2020a)
            obj.visSet =  ds2020a.vis();
        end
        
        function run(obj)
        % ������ܵ�ͬ�ڰ�ǰ��� RUN����
            fprintf(obj.visSet, ':RUN');
        end
        
        function stop(obj)
        % ������ܵ�ͬ�ڰ�ǰ��� STOP����
            fprintf(obj.visSet, ':STOP');
        end
         
         function autoScale(obj)
        % :AUToscale
        % �����ʽ
        % :AUToscale
        % ��������
        % ���ò����Զ����ù��ܡ�ʾ���������������ź��Զ�������ֱ��λ��ˮƽʱ���Լ�������ʽ��ʹ������ʾ
        % �ﵽ���״̬��������ܵ�ͬ�ڰ�ǰ��� AUTO ����
            fprintf(obj.visSet, ':AUToscale');
         end
        
         function clear(obj)
             fprintf(obj.visSet, ':CLEar');
         end
         
        function channelDisp(obj,channel,state)
        % :CHANnel<n>:DISPlay 
        % �����ʽ
        %:CHANnel<n>:DISPlay <bool>
        % �� :CHANnel<n>:DISPlay?
        %  ��������
        %  �򿪻�ر�ָ����ģ��ͨ�������ѯָ��ģ��ͨ����״̬
            fprintf(obj.visSet,strcat( ":CHANnel",num2str(channel),":DISPlay ",num2str(state) ) );
        end
        
        function channelScale(obj,channel,scale)
        % :CHANnel<n>:SCALe 
        % �����ʽ
        % :CHANnel<n>:SCALe <scale>
        % :CHANnel<n>:SCALe?
        % ��������
        % ���û��ѯָ��ģ��ͨ���Ĵ�ֱ��λ����λĬ��Ϊ V/div��
        %<scale>:ʵ�� �����迹Ϊ 50����̽ͷ��Ϊ 1X ʱ��500��V/div �� 1V/div
        %        �����迹Ϊ 1M����̽ͷ��Ϊ 1X ʱ��500��V/div �� 10V/div
            fprintf(obj.visSet,strcat(":CHANnel",num2str(channel),":SCALe ",num2str(scale)));
        end

        
        function turnKnob(obj,knob,dir)
        %������ť��ת��һ��
        %-------------------------------------------------------
        %knob:ѡ����ť����
        %VPOSition|VPOSition1��CH1 �Ĵ�ֱλ�Ƶ�����ť��
        % VPOSition2��CH2 �Ĵ�ֱλ�Ƶ�����ť��
        % VSCale|VSCale1��CH1 �Ĵ�ֱ��λ������ť��
        % VSCale2��CH2 �Ĵ�ֱ��λ������ť��
        % HSCale��ˮƽʱ��������ť��
        % HPOSition��ˮƽλ�Ƶ�����ť��
        % KFUNction���๦����ť�����ڲ������ȣ�������Ļ�Ҳ�˵����ػ�� Display �˵�ʱ��Ч����
        % TLEVel��������ƽ������ť��
        % SFINd��������ť�е��ڲ���ť
        %-------------------------------------------------------
        %dir:������ת����
        %1��˳ʱ�룬0����ʱ�룻
        %-------------------------------------------------------
            if dir
                fprintf(obj.visSet,strcat(":SYSTem:KEY:INCRease ", knob));
            else
                fprintf(obj.visSet,strcat(":SYSTem:KEY:DECRease ", knob));
            end
        end
        
    end
end

