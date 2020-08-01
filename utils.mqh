#include <Trade\Trade.mqh>

void printCandle(MqlRates &candle) {
   PrintFormat("O = %f, H = %f, L = %f, C = %f", candle.open, candle.high, candle.low, candle.close);
}

double lowestLow(MqlRates &rates[], int count) {
   double low = rates[0].low;
   for (int i = 1; i < count; i++) {
      MqlRates element = rates[i];
      if (element.low < low) {
         low = element.low;
      }
   }
   return (low);
};


double LongTakeProfit(double sl, double factor) {
   double price = SymbolInfoDouble(_Symbol, SYMBOL_BID);
   double distance = MathAbs(price - sl);
   return price + factor*distance;
};

double ShortTakeProfit(double sl, double factor) {
   double price = SymbolInfoDouble(_Symbol, SYMBOL_ASK);
   double distance = MathAbs(price - sl);
   return price - factor*distance;
}


double highestHigh(MqlRates &rates[], int count) {
   double high = rates[0].high;
   for (int i = 1; i < count; i++) {
      MqlRates element = rates[i];
      if (element.high > high) {
         high = element.high;
      }
   }
   return (high);
}

double lastBarWilliams(int handle, bool current = false) {
   int start = (current ? 0 : 1);
   double data[];
   CopyBuffer(handle, 0, start, 1, data);
   return data[0];
}


void ClosePositionsOfType(ENUM_POSITION_TYPE type) {
   CTrade trade;
   for (int i = 0; i < PositionsTotal(); i++) {
      ulong ticket = PositionGetTicket(i);
      PositionSelectByTicket(ticket);
      if (PositionGetInteger(POSITION_TYPE) == type) {
         trade.PositionClose(ticket);
      }
   }
}


int CountPositionsOfType(ENUM_POSITION_TYPE type) {
   int number = 0;
   for (int i = 0; i < PositionsTotal(); i++) {
      ulong ticket = PositionGetTicket(i);
      PositionSelectByTicket(ticket);
      if (PositionGetInteger(POSITION_TYPE) == type) {
         number++;
      }
   }
   return number;
}


void scalp_profits() {
   CTrade trade;
   for (int i = 0; i < PositionsTotal(); i++) {
      ulong ticket = PositionGetTicket(i);
      PositionSelectByTicket(ticket);
      double profit = PositionGetDouble(POSITION_PROFIT);
      if (profit > 7) 
         trade.PositionClose(ticket);
      if (profit < 0 && MathAbs(profit) > 4) 
         trade.PositionClose(ticket);
   }
}