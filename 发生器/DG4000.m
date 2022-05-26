classdef DG4000
    %DG4000
    
    properties(Access = public)
        vis
    end
    
    methods
        
        function obj = DG4000(id)
           obj.vis = visa('NI', id);
           disp("--Successfully find the equiment.");            
        end

        %% ********************文件打开和关闭**********************************
         function open(obj)
            %METHOD1 此处显示有关此方法的摘要
            fopen(obj.vis);    % Disconnect interface object from instrument
        end
        function close(obj)
            %METHOD1 此处显示有关此方法的摘要
            fclose(obj.vis);    % Disconnect interface object from instrument
            delete(obj.vis);    % Remove instrument objects from memory
        end
        
        %% ******************** 常用的设置函数 ********************
        function Channel(obj,source,state)
            if state 
                fprintf(obj.vis,strcat(":OUTPut",num2str(source)," ON"));
            else
                fprintf(obj.vis,strcat(":OUTPut",num2str(source)," OFF"));
            end
        end


        function SetVol(obj,source,vol)
            % 设置基本波的幅度，单位默认为"Vpp",默认值 5 Vpp
            fprintf(obj.vis,strcat(":SOURce",num2str(source),":VOLTage ",num2str(vol)));
        end
        
        function Setfreq(obj,source,freq)
            % 设置基本波的频率，单位默认为"Hz"，默认值1kHz
            fprintf(obj.vis,strcat(":SOURce",num2str(source),":FREQuency ",num2str(freq)));

        end
               

        function Setphase(obj,source,phase)
            % 设置基本波的起始相位.默认值为0 degree,范围为[0,360]
            fprintf(obj.vis,strcat(":SOURce",num2str(source),":PHASe ",num2str(phase)));
        end

        function SetSquare(obj,source,rate)
            % 设置方波占空比，以%表示,默认值是50%
            % eg: :FUNCtion:SQUare:DCYCle 80
            fprintf(obj.vis,strcat(":SOURce",num2str(source)," :FUNCtion:SQUare:DCYCle ",num2str(rate)));
        end

        function Shape(obj,source,type)
        % 形状设置
        % eg: :SOUR1:FUNC SQU 
        % wavename: |RAMP|PULSe||SINC|SQU:三角波，脉冲波，正弦波，方波
        % shape(obj,source,type)
            fprintf(obj.vis,strcat(":SOURce",num2str(source),":FUNC ",type));
        end

        function SetRamp(obj,source,sym)
            % 设置锯齿波的对称性，以%表示,默认值50%
            % eg: :FUNCtion:RAMP:SYMMetry 80
            fprintf(obj.vis,strcat(":SOURce",num2str(source),":FUNCtion:RAMP:SYMMetry ",num2str(sym)));

        end
       

        function GenerateSin(obj,source,freq,amp,offset,phase)
             % 向obj.visa【计算机将外设亦视为文件】写入命令
            fprintf(obj.vis,strcat(":SOURce",num2str(source),":APPLy:SINusoid ", ...
                num2str(freq),",", ...
                num2str(amp),",", ...
                num2str(offset),",", ...
                num2str(phase)));     
            
        end
        %% 调制设置
        function setMod(obj,source,state,type)
            % 打开或关闭调制
            % type为调制类型：AM|FM|PM|ASK|FSK|PSK|PWM|BPSK|QPSK|3FSK|4FSK|OSK，默认AM 
            if state
                fprintf(obj.vis,strcat(":SOURce",num2str(source),":MOD:TYPe ",type));
                fprintf(obj.vis,strcat(":SOURce",num2str(source),":MOD ON"));    
            else
                fprintf(obj.vis,strcat(":SOURce",num2str(source),":MOD OFF"));  
            end
        end
        
        function Setam(obj,source,mf,depth)
            %设置AM

            % 设置调制深度
            % eg::MOD:AM 80
            fprintf(obj.vis,strcat(":SOURce",num2str(source),":MOD:AM ",num2str(depth)));
            % 设置AM调制波的频率，单位默认为“Hz”。
            % eg::MOD:AM:INTernal:FREQuency 25
            fprintf(obj.vis,strcat(":SOURce",num2str(source),":MOD:AM:INTernal:FREQuency ",num2str(mf)));
            
        end

        function Setfm(obj,source,dev,mf)
            %设置FM

            % 设置频偏,单位为HZ，默认1kHz
            % eg::MOD:FM 800
            fprintf(obj.vis,strcat(":SOURce",num2str(source),":MOD:FM ",num2str(dev)));
            % 设置调制频率，单位Hz，默认为100Hz       
            % eg::MOD:FM:INTernal:FREQuency 25
            fprintf(obj.vis,strcat(":SOURce",num2str(source),":MOD:FM:INTernal:FREQuency ",num2str(mf)));
        end
    end
end
