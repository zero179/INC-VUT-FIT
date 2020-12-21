
--xfenko01
--Simon Fenko
--Code1=1564725116
--Code2=1560315756

library ieee;
use ieee.std_logic_1164.all;

-- ----------------------------------------------------------------------------
--                        Entity declaration
-- ----------------------------------------------------------------------------
entity fsm is
port(
   CLK         : in  std_logic;
   RESET       : in  std_logic;

   -- Input signals
   KEY         : in  std_logic_vector(15 downto 0);
   CNT_OF      : in  std_logic;

   -- Output signals
   FSM_CNT_CE  : out std_logic;
   FSM_MX_MEM  : out std_logic;
   FSM_MX_LCD  : out std_logic;
   FSM_LCD_WR  : out std_logic;
   FSM_LCD_CLR : out std_logic
);
end entity fsm;
-- ----------------------------------------------------------------------------
--                      Architecture declaration
-- ----------------------------------------------------------------------------
architecture behavioral of fsm is
   type t_state is (
         A1, A2, A3, A4, 
         A1_1, A1_2, A1_3, A1_4, A1_5, A1_6, A1_7,
         A2_1, A2_2, A2_3, A2_4, A2_5, A2_6, A2_7,
         BAD, ACCESS_DENIED, ACCESS_ALLOWED, FINISH
      );
   signal present_state, next_state : t_state;

begin
-- -------------------------------------------------------
sync_logic : process(RESET, CLK)
begin
   if (RESET = '1') then
      present_state <= A1;
   elsif (CLK'event AND CLK = '1') then
      present_state <= next_state;
   end if;
end process sync_logic;

-- -------------------------------------------------------
next_state_logic : process(present_state, KEY, CNT_OF)
begin
   case (present_state) is

   when A1 =>
     if (KEY(1) = '1') then
         next_state <= A2;
      elsif (KEY(15) = '1') then
         next_state <= ACCESS_DENIED;
      elsif (KEY(14 downto 0) /= "000000000000000") then
         next_state <= BAD;
      else
         next_state <= A1;
      end if;

   when A2 =>
     if (KEY(5) = '1') then
         next_state <= A3;
      elsif (KEY(15) = '1') then
         next_state <= ACCESS_DENIED;
      elsif (KEY(14 downto 0) /= "000000000000000") then
         next_state <= BAD;
      else
         next_state <= A2;
      end if;

   when A3 =>
     if (KEY(6) = '1') then
         next_state <= A4;
      elsif (KEY(15) = '1') then
         next_state <= ACCESS_DENIED;
      elsif (KEY(14 downto 0) /= "000000000000000") then
         next_state <= BAD;
      else
         next_state <= A3;
      end if;

   when A4 =>
     if (KEY(4) = '1') then
         next_state <= A1_1;
     elsif (KEY(0) = '1') then
         next_state <= A2_1;      
      elsif (KEY(15) = '1') then
         next_state <= ACCESS_DENIED;
      elsif (KEY(14 downto 0) /= "000000000000000") then
         next_state <= BAD;
      else
         next_state <= A4;
      end if;

   when A1_1 =>
     if (KEY(7) = '1') then
         next_state <= A1_2;
      elsif (KEY(15) = '1') then
         next_state <= ACCESS_DENIED;
      elsif (KEY(14 downto 0) /= "000000000000000") then
         next_state <= BAD;
      else
         next_state <= A1_1;
      end if;

   when A1_2 =>
     if (KEY(2) = '1') then
         next_state <= A1_3;
      elsif (KEY(15) = '1') then
         next_state <= ACCESS_DENIED;
      elsif (KEY(14 downto 0) /= "000000000000000") then
         next_state <= BAD;
      else
         next_state <= A1_2;
      end if;

   when A1_3 =>
     if (KEY(5) = '1') then
         next_state <= A1_4;
      elsif (KEY(15) = '1') then
         next_state <= ACCESS_DENIED;
      elsif (KEY(14 downto 0) /= "000000000000000") then
         next_state <= BAD;
      else
         next_state <= A1_3;
      end if;


   when A1_4 =>
     if (KEY(1) = '1') then
         next_state <= A1_5;
      elsif (KEY(14 downto 0) /= "000000000000000") then
         next_state <= BAD;
      else
         next_state <= A1_4;
      end if;
   
   when A1_5 =>
     if (KEY(1) = '1') then
         next_state <= A1_6;
      elsif (KEY(14 downto 0) /= "000000000000000") then
         next_state <= BAD;
      else
         next_state <= A1_5;
      end if;
     
   when A1_6 =>
     if (KEY(6) = '1') then
         next_state <= A1_7;
      elsif (KEY(14 downto 0) /= "000000000000000") then
         next_state <= BAD;
      else
         next_state <= A1_6;
      end if;

   when A1_7 =>
     if (KEY(15) = '1') then
         next_state <= ACCESS_ALLOWED;
      elsif (KEY(14 downto 0) /= "000000000000000") then
         next_state <= BAD;
      else
         next_state <= A1_7;
      end if;
   
   when A2_1 =>
     if (KEY(3) = '1') then
         next_state <= A2_2;
      elsif (KEY(15) = '1') then
         next_state <= ACCESS_DENIED;
      elsif (KEY(14 downto 0) /= "000000000000000") then
         next_state <= BAD;
      else
         next_state <= A2_1;
      end if;

   when A2_2 =>
     if (KEY(1) = '1') then
         next_state <= A2_3;
      elsif (KEY(15) = '1') then
         next_state <= ACCESS_DENIED;
      elsif (KEY(14 downto 0) /= "000000000000000") then
         next_state <= BAD;
      else
         next_state <= A2_2;
      end if;

   when A2_3 =>
     if (KEY(5) = '1') then
         next_state <= A2_4;
      elsif (KEY(15) = '1') then
         next_state <= ACCESS_DENIED;
      elsif (KEY(14 downto 0) /= "000000000000000") then
         next_state <= BAD;
      else
         next_state <= A2_3;
      end if;

   when A2_4 =>
      if (KEY(7) = '1') then
         next_state <= A2_5;
      elsif (KEY(15) = '1') then
         next_state <= ACCESS_DENIED;
      elsif (KEY(14 downto 0) /= "000000000000000") then
         next_state <= BAD;
      else
         next_state <= A2_4;
      end if;

   when A2_5 =>
     if (KEY(5) = '1') then
         next_state <= A2_6;
      elsif (KEY(15) = '1') then
         next_state <= ACCESS_DENIED;
      elsif (KEY(14 downto 0) /= "000000000000000") then
         next_state <= BAD;
      else
         next_state <= A2_5;
      end if;

   when A2_6 =>
     if (KEY(6) = '1') then
         next_state <= A2_7;
      elsif (KEY(14 downto 0) /= "000000000000000") then
         next_state <= BAD;
      else
         next_state <= A2_6;
      end if;

   when A2_7 =>
     if (KEY(15) = '1') then
         next_state <= ACCESS_ALLOWED;
      elsif (KEY(14 downto 0) /= "000000000000000") then
         next_state <= BAD;
      else
         next_state <= A2_7;
      end if;

   when BAD =>
      next_state <= BAD;
      if (KEY(15) = '1') then
         next_state <= ACCESS_DENIED;
      end if;

   when ACCESS_ALLOWED =>
      next_state <= ACCESS_ALLOWED;
      if (CNT_OF = '1') then
         next_state <= FINISH;
      end if;

   when ACCESS_DENIED =>
      next_state <= ACCESS_DENIED;
      if (CNT_OF = '1') then
         next_state <= FINISH;
      end if;
   
   when FINISH =>
      next_state <= FINISH;
      if (KEY(15) = '1') then
         next_state <= A1;
      end if;

   when others =>
      null;
   end case;
end process next_state_logic;
     
-- -------------------------------------------------------
output_logic : process(present_state, KEY)
begin
   FSM_CNT_CE     <= '0';
   FSM_MX_MEM     <= '0';
   FSM_MX_LCD     <= '0';
   FSM_LCD_WR     <= '0';
   FSM_LCD_CLR    <= '0';
  
   case (present_state) is
     
   when ACCESS_DENIED =>
      FSM_CNT_CE <= '1';
      FSM_MX_LCD <= '1';

      if (CNT_OF = '0') then
         FSM_LCD_WR <= '1';
      end if;

   when ACCESS_ALLOWED =>
      FSM_CNT_CE <= '1';
      FSM_MX_MEM <= '1';
      FSM_MX_LCD <= '1';

      if (CNT_OF = '0') then
         FSM_LCD_WR <= '1';
      end if;

   when FINISH =>
      if (KEY(15) = '1') then
         FSM_LCD_CLR <= '1';
      end if;

   when others =>
      if (KEY(15) = '1') then
         FSM_LCD_CLR <= '1';
      elsif (KEY(14 downto 0) /= "000000000000000") then
         FSM_LCD_WR <= '1';
      end if;
   end case;

end process output_logic;

end architecture behavioral;
