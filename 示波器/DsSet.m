classdef DsSet
    %DSSET: DS2020A的子类，作用是设置外设的各种参数 
    properties
        visSet 
    end
    
    methods
        function obj = DsSet(ds2020a)
            obj.visSet =  ds2020a.vis();
        end
        
        function run(obj)
        % 该命令功能等同于按前面板 RUN按键
            fprintf(obj.visSet, ':RUN');
        end
        
        function stop(obj)
        % 该命令功能等同于按前面板 STOP按键
            fprintf(obj.visSet, ':STOP');
        end
         
         function autoScale(obj)
        % :AUToscale
        % 命令格式
        % :AUToscale
        % 功能描述
        % 启用波形自动设置功能。示波器将根据输入信号自动调整垂直档位、水平时基以及触发方式，使波形显示
        % 达到最佳状态。该命令功能等同于按前面板 AUTO 按键
            fprintf(obj.visSet, ':AUToscale');
         end
        
         function clear(obj)
             fprintf(obj.visSet, ':CLEar');
         end
         
        function channelDisp(obj,channel,state)
        % :CHANnel<n>:DISPlay 
        % 命令格式
        %:CHANnel<n>:DISPlay <bool>
        % 或 :CHANnel<n>:DISPlay?
        %  功能描述
        %  打开或关闭指定的模拟通道，或查询指定模拟通道的状态
            fprintf(obj.visSet,strcat( ":CHANnel",num2str(channel),":DISPlay ",num2str(state) ) );
        end
        
        function channelScale(obj,channel,scale)
        % :CHANnel<n>:SCALe 
        % 命令格式
        % :CHANnel<n>:SCALe <scale>
        % :CHANnel<n>:SCALe?
        % 功能描述
        % 设置或查询指定模拟通道的垂直档位，单位默认为 V/div。
        %<scale>:实型 输入阻抗为 50Ω，探头比为 1X 时：500μV/div 至 1V/div
        %        输入阻抗为 1MΩ，探头比为 1X 时：500μV/div 至 10V/div
            fprintf(obj.visSet,strcat(":CHANnel",num2str(channel),":SCALe ",num2str(scale)));
        end

        
        function turnKnob(obj,knob,dir)
        %控制旋钮的转动一次
        %-------------------------------------------------------
        %knob:选择旋钮种类
        %VPOSition|VPOSition1：CH1 的垂直位移调节旋钮；
        % VPOSition2：CH2 的垂直位移调节旋钮；
        % VSCale|VSCale1：CH1 的垂直档位调节旋钮；
        % VSCale2：CH2 的垂直档位调节旋钮；
        % HSCale：水平时基调节旋钮；
        % HPOSition：水平位移调节旋钮；
        % KFUNction：多功能旋钮，调节波形亮度（仅当屏幕右侧菜单隐藏或打开 Display 菜单时有效）；
        % TLEVel：触发电平调节旋钮；
        % SFINd：导航旋钮中的内层旋钮
        %-------------------------------------------------------
        %dir:控制旋转方向
        %1：顺时针，0：逆时针；
        %-------------------------------------------------------
            if dir
                fprintf(obj.visSet,strcat(":SYSTem:KEY:INCRease ", knob));
            else
                fprintf(obj.visSet,strcat(":SYSTem:KEY:DECRease ", knob));
            end
        end
        
    end
end

