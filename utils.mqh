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