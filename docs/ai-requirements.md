# AI Competitors Requirements

## Overview
Add AI trading bots based on famous stock traders to custom games, providing competitive gameplay and educational value through different trading personalities and skill levels.

## Core AI System

### AI Trader Personalities
1. **Nancy "The Insider" (A+ Rating)**
   - **Trading Style**: High conviction, large positions, excellent timing
   - **Sector Focus**: Healthcare, technology, infrastructure
   - **Lookback Window**: 10 minutes
   - **Trade Size**: 10-25% of available cash per trade
   - **Special Ability**: Enhanced performance on policy-sensitive sectors

2. **Warren "The Oracle" (B+ Rating)**
   - **Trading Style**: Value investing, long-term holds, conservative
   - **Sector Focus**: Established companies, dividends, fundamentals
   - **Lookback Window**: 5 minutes
   - **Trade Size**: 3-8% of available cash per trade
   - **Special Ability**: Immune to market panic (doesn't sell during crashes)

3. **Elon "The Maverick" (A Rating)**
   - **Trading Style**: Volatile, contrarian bets, innovation-focused
   - **Sector Focus**: Technology, clean energy, space/automotive
   - **Lookback Window**: 7 minutes
   - **Trade Size**: 5-30% of available cash per trade
   - **Special Ability**: Occasional "moonshot" investments with high risk/reward

### Rating System
- **D-C Tier**: No lookback, slower execution (educational/beginner)
- **B Tier**: 2-5 minute lookback window
- **A Tier**: 5-7 minute lookback window
- **A+ Tier**: 10+ minute lookback + fastest execution

## Technical Requirements

### Time Lookback Mechanism
- AIs can execute trades using historical prices within their lookback window
- **Buy orders**: Select lowest price in window
- **Sell orders**: Select highest price in window
- **Transparency**: Show timestamp of actual execution price to players

### Percentage-Based Trading
- All trade amounts calculated as percentage of AI's current cash balance
- Scales automatically with custom game starting amounts
- Each AI has personality-specific percentage ranges

### Game Integration
- **Global AI Pool**: Single instance of each AI serves all games
- **Custom Game Setup**: Host can add 1-3 AIs during game creation
- **Starting Balance**: AIs receive same starting cash as human players
- **Trade Frequency**: AIs limited to trades every 2-3 minutes minimum

## Questions for Clarification

### Current Game Architecture
1. Where is the custom game logic implemented? (Web app source code location)
2. What's the current player limit for custom games?
3. How is real-time game state synchronized between players?
4. What backend technology stack is being used?

### AI Integration Specifics
1. Should AIs be added only during game creation, or can they join mid-game?
2. Do AIs need visible profiles/avatars like human players?
3. Should there be an in-game cost to add AI players?
4. How chatty should AIs be? (Just trade notifications vs. personality comments)

### Technical Implementation
1. How is market data currently fetched and updated?
2. Are WebSockets used for real-time updates?
3. What's the current human trading frequency limit enforcement?
4. How are custom game settings (starting cash, duration) currently stored?

## Success Criteria
- [ ] AIs provide challenging but fair competition
- [ ] Each AI personality feels distinct and educational
- [ ] System scales with any custom game starting balance
- [ ] Performance doesn't impact human player experience
- [ ] Easy to add new AI personalities in the future

## Future Considerations
- AI difficulty progression for player skill development
- Tournament modes with AI participants
- AI learning from player behavior patterns
- Additional trader personalities (Jim Cramer, Cathie Wood, etc.)