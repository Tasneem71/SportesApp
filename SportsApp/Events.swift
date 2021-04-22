/* 
Copyright (c) 2021 Swift Models Generated from JSON powered by http://www.json4swift.com

Permission is hereby granted, free of charge, to any person obtaining a copy of this software and associated documentation files (the "Software"), to deal in the Software without restriction, including without limitation the rights to use, copy, modify, merge, publish, distribute, sublicense, and/or sell copies of the Software, and to permit persons to whom the Software is furnished to do so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in all copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.

For support, please feel free to contact me at https://www.linkedin.com/in/syedabsar

*/

import Foundation
struct Events : Codable {
	let idEvent : String?
	let idSoccerXML : String?
	let idAPIfootball : String?
	let strEvent : String?
	let strEventAlternate : String?
	let strFilename : String?
	let strSport : String?
	let idLeague : String?
	let strLeague : String?
	let strSeason : String?
	let strDescriptionEN : String?
	let strHomeTeam : String?
	let strAwayTeam : String?
	let intHomeScore : String?
	let intRound : String?
	let intAwayScore : String?
	let intSpectators : String?
	let strOfficial : String?
	let strHomeGoalDetails : String?
	let strHomeRedCards : String?
	let strHomeYellowCards : String?
	let strHomeLineupGoalkeeper : String?
	let strHomeLineupDefense : String?
	let strHomeLineupMidfield : String?
	let strHomeLineupForward : String?
	let strHomeLineupSubstitutes : String?
	let strHomeFormation : String?
	let strAwayRedCards : String?
	let strAwayYellowCards : String?
	let strAwayGoalDetails : String?
	let strAwayLineupGoalkeeper : String?
	let strAwayLineupDefense : String?
	let strAwayLineupMidfield : String?
	let strAwayLineupForward : String?
	let strAwayLineupSubstitutes : String?
	let strAwayFormation : String?
	let intHomeShots : String?
	let intAwayShots : String?
	let strTimestamp : String?
	let dateEvent : String?
	let dateEventLocal : String?
	let strTime : String?
	let strTimeLocal : String?
	let strTVStation : String?
	let idHomeTeam : String?
	let idAwayTeam : String?
	let strResult : String?
	let strVenue : String?
	let strCountry : String?
	let strCity : String?
	let strPoster : String?
	let strSquare : String?
	let strFanart : String?
	let strThumb : String?
	let strBanner : String?
	let strMap : String?
	let strTweet1 : String?
	let strTweet2 : String?
	let strTweet3 : String?
	let strVideo : String?
	let strStatus : String?
	let strPostponed : String?
	let strLocked : String?

	enum CodingKeys: String, CodingKey {

		case idEvent = "idEvent"
		case idSoccerXML = "idSoccerXML"
		case idAPIfootball = "idAPIfootball"
		case strEvent = "strEvent"
		case strEventAlternate = "strEventAlternate"
		case strFilename = "strFilename"
		case strSport = "strSport"
		case idLeague = "idLeague"
		case strLeague = "strLeague"
		case strSeason = "strSeason"
		case strDescriptionEN = "strDescriptionEN"
		case strHomeTeam = "strHomeTeam"
		case strAwayTeam = "strAwayTeam"
		case intHomeScore = "intHomeScore"
		case intRound = "intRound"
		case intAwayScore = "intAwayScore"
		case intSpectators = "intSpectators"
		case strOfficial = "strOfficial"
		case strHomeGoalDetails = "strHomeGoalDetails"
		case strHomeRedCards = "strHomeRedCards"
		case strHomeYellowCards = "strHomeYellowCards"
		case strHomeLineupGoalkeeper = "strHomeLineupGoalkeeper"
		case strHomeLineupDefense = "strHomeLineupDefense"
		case strHomeLineupMidfield = "strHomeLineupMidfield"
		case strHomeLineupForward = "strHomeLineupForward"
		case strHomeLineupSubstitutes = "strHomeLineupSubstitutes"
		case strHomeFormation = "strHomeFormation"
		case strAwayRedCards = "strAwayRedCards"
		case strAwayYellowCards = "strAwayYellowCards"
		case strAwayGoalDetails = "strAwayGoalDetails"
		case strAwayLineupGoalkeeper = "strAwayLineupGoalkeeper"
		case strAwayLineupDefense = "strAwayLineupDefense"
		case strAwayLineupMidfield = "strAwayLineupMidfield"
		case strAwayLineupForward = "strAwayLineupForward"
		case strAwayLineupSubstitutes = "strAwayLineupSubstitutes"
		case strAwayFormation = "strAwayFormation"
		case intHomeShots = "intHomeShots"
		case intAwayShots = "intAwayShots"
		case strTimestamp = "strTimestamp"
		case dateEvent = "dateEvent"
		case dateEventLocal = "dateEventLocal"
		case strTime = "strTime"
		case strTimeLocal = "strTimeLocal"
		case strTVStation = "strTVStation"
		case idHomeTeam = "idHomeTeam"
		case idAwayTeam = "idAwayTeam"
		case strResult = "strResult"
		case strVenue = "strVenue"
		case strCountry = "strCountry"
		case strCity = "strCity"
		case strPoster = "strPoster"
		case strSquare = "strSquare"
		case strFanart = "strFanart"
		case strThumb = "strThumb"
		case strBanner = "strBanner"
		case strMap = "strMap"
		case strTweet1 = "strTweet1"
		case strTweet2 = "strTweet2"
		case strTweet3 = "strTweet3"
		case strVideo = "strVideo"
		case strStatus = "strStatus"
		case strPostponed = "strPostponed"
		case strLocked = "strLocked"
	}


}
