extends Node

signal next_type()
signal send_tea()

enum INGREDIENTS {
	NONE,
	MATCHA,
	CHAMOMILE,
	OOLONG,
	HIBISCUS,
	CHAI,
	EARLGREY,
	SUGAR,
	HONEY,
	MAPLESYRUP,
	AGAVENECTAR,
	MOLASSES,
	APPLEJUICE,
	LEMON,
	MILK,
	CINNAMON,
	MINT,
	GINGER,
	CUCUMBER,
	HOT,
	COLD
}

enum TYPES {
	TEA,
	SWEETENER,
	EXTRA,
	TEMPERATURE
}

var tea_clues : Dictionary = {
	"matcha": [
		"grassy",
		"earthy",
		"vibrant",
		"bitter",
		"smooth"
	],
	"chamomile": [
		"floral",
		"soothing",
		"mellow",
		"herbal",
		"gentle"
	],
	"oolong": [
		"roasted",
		"nutty",
		"rich",
		"toasty",
		"deep"
	],
	"hibiscus": [
		"tart",
		"fruity",
		"bright",
		"tangy",
		"zesty"
	],
	"chai": [
		"spiced",
		"warm",
		"aromatic",
		"cozy",
		"bold"
	],
	"earlgrey": [
		"citrusy",
		"fragrant",
		"distinctive",
		"elegant",
		"perfumed"
	]
}

var sweetener_clues : Dictionary = {
	"sugar": [
		"granulated",
		"plain",
		"crystalline",
		"candy-like",
		"powdery"
	],
	"honey": [
		"golden",
		"sticky",
		"nectar-like",
		"silky",
		"buttery"
	],
	"maplesyrup": [
		"woody",
		"syrupy",
		"rustic",
		"caramel-like",
		"toffee-like"
	],
	"agavenectar": [
		"mild",
		"light",
		"subtle",
		"cactus-like",
		"neutral"
	],
	"molasses": [
		"dark",
		"smoky",
		"heavy",
		"burnt",
		"robust"
	],
	"applejuice": [
		"orchardy",
		"ripe",
		"juicy",
		"cider-like",
		"fresh"
	]
}

var extra_clues : Dictionary = {
	"lemon": [
		"sour",
		"sharp",
		"puckering",
		"acidic",
		"sprightly"
	],
	"milk": [
		"creamy",
		"velvety",
		"thick",
		"soft",
		"smooth-textured"
	],
	"cinnamon": [
		"spicy",
		"sweet",
		"fiery",
		"festive",
		"comforting"
	],
	"mint": [
		"cooling",
		"crisp",
		"refreshing",
		"invigorating",
		"bracing"
	],
	"ginger": [
		"peppery",
		"zingy",
		"pungent",
		"tingly",
		"punchy"
	],
	"cucumber": [
		"watery",
		"clean",
		"delicate",
		"garden-fresh",
		"dewy"
	]
}

var temperature_clues : Dictionary = {
	"hot": [
		"steaming",
		"warm",
		"piping",
		"heated",
		"scalding"
	],
	"cold": [
		"chilled",
		"cool",
		"icy",
		"lukewarm",
		"frosty"
	]
}

var ingredient_colors : Dictionary = {
	"matcha": Color("#a9ffab"),
	"chamomile": Color("#ffdd9a"),
	"oolong": Color("#f2bda6"),
	"hibiscus": Color("#ff7070"),
	"chai": Color("#e1bf60"),
	"earlgrey": Color("#a0835a"),

	"sugar": Color("#ffffff"),
	"honey": Color("#fed807"),
	"maplesyrup": Color("#985734"),
	"agavenectar": Color("#ad792c"),
	"molasses":  Color("#292a25"),
	"applejuice": Color("#a27f52"),

	"lemon": Color("#f4db5b"),
	"milk": Color("#d1dadc"),
	"cinnamon": Color("#86471c"),
	"mint": Color("#77c029"),
	"ginger": Color("#dbb68a"),
	"cucumber": Color("#51893e")
}

var ingredient_descriptions : Dictionary = {
	"matcha": "A Japanese tea made by grinding whole leaves into a fine powder that is whisked into water. It has a leafy character, a pronounced flavor, and a slightly astringent finish.",
	"chamomile": "A caffeine-free infusion made from dried chamomile flowers. It has a delicate character with a gentle aroma and is commonly enjoyed in the evening or before bed.",
	"oolong": "A traditional Chinese tea made from leaves that are partially oxidized before drying. Its character can range from lighter varieties to stronger, more developed brews with hints of nuts or toasted leaves.",
	"hibiscus": "A caffeine-free infusion made from dried hibiscus petals that produces a deep red drink. Its flavor has a sharp fruit-like quality and can be especially lively when served over ice.",
	"chai": "A tea traditionally made with black tea and a mixture of spices such as cinnamon, cardamom, ginger, and cloves. It has a pronounced spice character and is often served with milk.",
	"earlgrey": "A black tea flavored with oil from the peel of bergamot oranges. The orange-like character stands out clearly, giving the drink a recognizable and refined profile.",

	"sugar": "A common sweetening ingredient made from sugarcane or sugar beets. It dissolves easily into drinks and is often used when a straightforward increase in sweetness is desired.",
	"honey": "A natural sweetener made by bees from flower nectar. It has a smooth consistency and a distinctive character that can vary depending on the flowers the bees visited.",
	"maplesyrup": "A syrup produced by collecting sap from maple trees and concentrating it through heating. It has a tree-derived character with a flavor often associated with pancakes, waffles, and autumn foods.",
	"agavenectar": "A sweet liquid produced from the agave plant. It blends easily into drinks and has a more restrained character than many traditional sweeteners.",
	"molasses": "A thick liquid produced during the process of making sugar. It has a pronounced flavor with qualities often associated with dark baked goods, gingerbread, and brown sugar.",
	"applejuice": "A drink made by pressing apples and removing most of the solid fruit material. It carries the familiar flavor of ripe apples and can resemble the character of a freshly pressed orchard drink.",

	"lemon": "A yellow citrus fruit whose juice and peel are commonly added to drinks and cooking. Its juice gives beverages a strong sour sensation with a sharp, mouth-watering finish.",
	"milk": "A dairy liquid commonly obtained from cows and widely used in beverages, baking, and cooking. It adds body to a drink and gives it a softer, richer mouthfeel.",
	"cinnamon": "A spice made from the inner bark of several tree species. It has a strong presence in drinks and desserts and is closely associated with baked goods, pastries, and seasonal recipes.",
	"mint": "An aromatic herb whose leaves are often used in drinks, desserts, and cooking. It creates a cooling sensation in the mouth and leaves a noticeable aftertaste.",
	"ginger": "A root commonly used in cooking and beverages, either sliced, grated, or pressed for its juice. It has a strong presence that can create a noticeable sensation on the tongue.",
	"cucumber": "A vegetable with a high water content that is often sliced or blended into drinks and food. It contributes a watery character and a faint garden-like freshness without overpowering the other ingredients."
}

var order_dialogue_templates : Dictionary = {
	"polite": [
		[
			"I'd like something ",
			", with something ",
			". Maybe something ",
			" and nice and ",
			"."
		],
		[
			"Could I have something ",
			"? I'd like it ",
			", with a touch of something ",
			". And please make it ",
			"."
		],
		[
			"Something ",
			" sounds nice. I'd also like something ",
			" and something ",
			". I'd prefer it ",
			"."
		],
		[
			"I'd love something ",
			", ",
			", and ",
			". And could you make it ",
			"?"
		],
		[
			"I think I'll have something ",
			" today, with something ",
			" and something ",
			". Something ",
			" would be perfect."
		],
		[
			"Something ", 
			" with something ",
			" and something ",
			", please. And not too far from ",
			"."
		],
		[
			"Would you be a darling and make something ",
			" with something ",
			" and something ",
			". Don't forget to keep it ",
			"."
		],
		[
			"Could you make me something ",
			", with something ",
			" and something ",
			"? I'd like it ",
			"."
		]
	],
	"cheerful": [
		[
			"Ooh, I want something ",
			"! Make it ",
			", add something ",
			", and keep it ",
			"."
		],
		[
			"I've got a craving today! Something ",
			", ",
			", with something ",
			" and definitely something ",
			"."
		],
		[
			"Let's see... something ",
			", something ",
			", something ",
			", and something ",
			". Perfect!"
		],
		[
			"I know exactly what I want! Something ",
			" with something ",
			" and something ",
			". Oh, and make it ",
			"."
		],
		[
			"Something ",
			" sounds AMAZING right now! With something ",
			", something ",
			", and something nice and ",
			"."
		],
		[
			"Can I get something ",
			"? And something ",
			"! And also something ",
			"! Can't forget to have it ",
			"! Thanks!"
		],
		[
			"Hellloooooo and good day! Could I have something ",
			", ",
			", and ",
			"? Let's go with something ",
			" as well. Thanks a bunch!"
		]
	],
	"shy": [
		[
			"Um... could I have something ",
			"? With something ",
			" please... and maybe something ",
			"? Oh, something ",
			" too. Thanks."
		],
		[
			"I was thinking... something ",
			", I guess. Maybe something ",
			" and something ",
			"? Also... something ",
			". Yeah."
		],
		[
			"Sorry if I'm a little picky... I'd like something ",
			", ",
			", and ",
			" . If it's not too hard, maybe something ",
			"? Sorry for the long order. Thank you so much"
		]
	],
	"blunt": [
		[
			"",
			".",
			".",
			".",
			"."
		],
		[
			"I want something ",
			", ",
			", ",
			", and ",
			"."
		],
		[
			"Make me something ",
			" with something ",
			" and something ",
			", and make it ",
			"."
		]
	],
	"chatty": [
		[
			"I've been thinking about this all day! So I want something ",
			", with something ",
			" and something ",
			". And I'd love if you could make it ",
			"! Thanksss!"
		],
		[
			"Ya know what sounds great? Something ",
			". Something ",
			" and something ",
			" and definitely something ",
			". Amazing!"
		],
		[
			"I've had a genuinely, actually, really weird day. So it started with [blah blah blah]... so can I get something ",
			"? And something ",
			", and something ",
			", and something ",
			". Awesomee!"
		],
		[
			"Let me order something unusual today... how about something ",
			"? With lots of something ",
			" and a tad bit of something ",
			". Can't forget to keep it ",
			". Yeah, that sounds like an odd combo."
		],
		[
			"I've been going back and forth in my mind on what to order for HOURS! But I think I'll settle on something ",
			" and ",
			". Yeah, also with something ",
			", and I like it ",
			". Thanks a million!"
		]
	],
	"tired": [
		[
			"Something ",
			" would be nice... and something ",
			"... oh yeah and something ",
			" . Um ",
			" please. Right."
		],
		[
			"I'm too tired to think. Just get me something ",
			", ",
			", and ",
			". I'll take it ",
			". Humph."
		],
		[
			"Ughhhh just gimme something ",
			" with something ",
			" and something ",
			" and make it ",
			". Mmmmmmm"
		]
	]
}

var job_secret_dialogue_templates : Dictionary = {
	"librarian": {
		"polite": [
			"I work at the library. It's a quiet place, and I rather enjoy that.",
			"We received several new books this week. I've been helping get them onto the shelves.",
			"One of the regulars asked me about a book today. They always seem to find the ones I happen to like.",
			"I found an old book that had been sitting untouched for years. I decided to clean it up and put it somewhere more visible.",
			"That old book actually disappeared from the shelf today. I'm glad someone finally noticed it.",
			"I've started keeping an eye out for other neglected books. It feels nice giving them another chance.",
			"I think that's what I like most about the library. You never really know whose life you're going to quietly improve."
		],
		"cheerful": [
			"I work at the library! It's usually pretty quiet, but I love being around all those books.",
			"We got a whole cart of new arrivals today! I wanted to read half of them myself.",
			"Someone came in looking for a book they'd loved as a kid. We actually found it!",
			"I found this really old book tucked away on a shelf. It looked like nobody had touched it forever.",
			"Someone checked that old book out today! I was weirdly excited about it.",
			"Now I've started noticing other books that nobody seems to look at. I'm going to see if I can get people interested in them too.",
			"Maybe that's my favorite part of the job. A book can wait years for the right person to come along."
		],
		"shy": [
			"Um... I work at the library. I mostly help people find things.",
			"We got some new books recently. I helped put them away... and maybe read a few pages.",
			"A regular came in today and asked me for a recommendation. I was nervous, but they liked my suggestion.",
			"I found an old book that nobody had checked out in a really long time.",
			"I mentioned it to someone today... and they actually borrowed it.",
			"I think I'm going to keep recommending the books that usually get overlooked.",
			"Maybe... I like being the person who helps people find something they didn't know they needed."
		],
		"blunt": [
			"I work at the library. Mostly books and people asking where things are.",
			"We got new books. Had to sort them all.",
			"One of the regulars asked me for a recommendation. I gave them one.",
			"They actually liked it. Good.",
			"Found an old book nobody was reading. Put it somewhere easier to notice.",
			"Someone borrowed it. Guess that worked.",
			"I might keep doing that. Seems better than letting good books collect dust."
		],
		"chatty": [
			"I work at the library! It's funny, because people assume it's boring, but something is always happening.",
			"We got new books today, and then someone immediately asked me if we'd gotten a book that literally arrived yesterday.",
			"One of the regulars asked me for a recommendation, which sounds simple until you realize you have to somehow figure out what kind of person they are first.",
			"I found this old book that had been sitting untouched forever, and then I started wondering who had checked it out last.",
			"I told someone about it today, and they actually borrowed it! I felt like I'd successfully rescued it.",
			"Now I'm noticing all these forgotten books and thinking about who might enjoy them. I may have accidentally given myself another project.",
			"I suppose that's what I like about the library. There's always another story waiting for someone to notice it."
		],
		"tired": [
			"I work at the library... mostly shelves, books, and people.",
			"We got new arrivals today. Had to put all of them away.",
			"A regular asked me for a recommendation. I gave them one.",
			"They liked it, apparently.",
			"I found an old book nobody had touched in years. Felt kind of bad for it.",
			"Someone borrowed it today. At least it's getting used now.",
			"Maybe that's enough. Just helping a few things find where they belong."
		]
	},

	"teacher": {
		"polite": [
			"I'm a teacher. The days can be rather busy, but I enjoy helping students learn.",
			"One of my students has been struggling with a particular subject. We've been working through it together.",
			"They came to me again today with another question. It's encouraging to see them keep trying.",
			"They finally understood something they'd been stuck on. Their expression changed immediately.",
			"I think that may be one of the most rewarding parts of teaching.",
			"They've started helping another student with the same topic. I didn't even ask them to.",
			"Sometimes progress is much quieter than you expect. You just have to notice it."
		],
		"cheerful": [
			"I'm a teacher! My class keeps me busy, but they're a fun bunch.",
			"One student has been having trouble with a lesson. They really want to get it right, though.",
			"They stayed after class today to ask me about it again! I was so proud of them for not giving up.",
			"They finally got it! Their face absolutely lit up.",
			"Now they're answering questions in class instead of avoiding them.",
			"They even helped someone else today! I couldn't believe how quickly their confidence changed.",
			"Moments like that make all the chaotic days worth it."
		],
		"shy": [
			"Um... I'm a teacher. My students can be a little overwhelming sometimes.",
			"There's one student who's been struggling lately. I don't think they like asking for help.",
			"They stayed after class today, though. I was glad they decided to ask me something.",
			"They understood part of it. Not everything, but... it was progress.",
			"They came back again the next day. I think they're starting to believe they can do it.",
			"Today they explained something to another student before I could.",
			"I don't know... I think I'm more proud of them than I expected."
		],
		"blunt": [
			"I'm a teacher. Today was loud.",
			"One student has been struggling with a lesson.",
			"They keep asking questions, which is better than giving up.",
			"They finally understood it.",
			"Now they're actually participating.",
			"They helped another student today.",
			"Good. That's what I wanted to see."
		],
		"chatty": [
			"I'm a teacher! You'd think I'd get used to how unpredictable students are, but somehow they still surprise me.",
			"There's one student who's been struggling with a lesson, and they've been trying really hard to hide it.",
			"They finally asked me for help, which was a pretty big deal because they usually pretend everything is fine.",
			"They got part of it today, and then suddenly they went, 'Wait, I get it!' It was adorable.",
			"They've started participating more in class, too.",
			"And then today they explained the same thing to another student. I just stood there thinking, 'When did you get so confident?'",
			"That's probably my favorite part of teaching. Watching someone slowly become a person who believes in themselves."
		],
		"tired": [
			"I'm a teacher... one of my students has been struggling lately.",
			"They've been asking a lot of questions.",
			"They finally understood one part today.",
			"Then another part.",
			"Now they're actually answering questions in class.",
			"They helped another student today.",
			"Maybe they're going to be okay after all."
		]
	},

	"baker": {
		"polite": [
			"I work at a bakery. The mornings can be rather early, but I enjoy the work.",
			"We've been experimenting with a few new recipes lately.",
			"I tried changing one of our usual recipes. It was a little risky, but I wanted to see what happened.",
			"The first attempt wasn't quite right. It needed another try.",
			"I made it again today, and this time it came out much better.",
			"A few customers tried it and seemed to enjoy it. That was reassuring.",
			"I think we'll keep it on the menu. It's nice when an experiment becomes something real."
		],
		"cheerful": [
			"I work at a bakery! We make all sorts of things, and I love trying new recipes.",
			"I've been working on a new pastry lately. The first version was... questionable.",
			"I changed a few things and tried again!",
			"It finally came out the way I wanted! I was ridiculously excited.",
			"We let some customers try it today.",
			"They actually liked it! I'm already thinking about how to make it even better.",
			"Maybe someday it'll become one of the bakery's regular favorites!"
		],
		"shy": [
			"Um... I work at a bakery. I mostly stay in the kitchen.",
			"I've been trying to make something new lately... I wasn't sure if I should.",
			"The first attempt wasn't very good.",
			"I tried again today, though.",
			"It turned out better. Not perfect, but better.",
			"Someone tried it and actually asked if we'd make it again.",
			"I think... I'd like to keep working on it."
		],
		"blunt": [
			"I'm a baker. Wake up early, make food, clean up.",
			"I've been testing a new recipe.",
			"First version was bad.",
			"Second was better.",
			"Someone actually liked it.",
			"Might keep making it.",
			"Maybe it'll become a regular."
		],
		"chatty": [
			"I work at a bakery! We make a ridiculous number of things every morning, and somehow I still want to try making more.",
			"I started experimenting with a new recipe, which was probably a mistake because the first attempt was awful.",
			"But then I started changing little things, and suddenly I was completely obsessed with getting it right.",
			"I finally made a version I liked today!",
			"We gave some to customers, and a few people actually asked what it was.",
			"Now I'm already thinking about how to improve it, because apparently I can't just leave anything alone.",
			"Maybe that's why I like baking. There's always another version to try."
		],
		"tired": [
			"I'm a baker... which means I'm awake before most people.",
			"I've been testing a new recipe.",
			"The first attempt was terrible.",
			"The second was better.",
			"Someone actually liked it today.",
			"So I guess I have to make more now.",
			"Could be worse. At least the kitchen smells good."
		]
	},

	"florist": {
		"polite": [
			"I work at a flower shop. I enjoy putting arrangements together for people.",
			"We've had several unusual orders lately. They've been rather interesting to work on.",
			"One customer asked for something that reminded them of home. I spent quite a while thinking about it.",
			"I eventually found an arrangement that seemed right.",
			"They came back to thank me. Apparently, I got closer than they expected.",
			"Since then, I've been paying more attention to the reasons people choose certain flowers.",
			"I think that's what makes the work meaningful. The flowers usually say more than people realize."
		],
		"cheerful": [
			"I work at a flower shop! You'd be surprised how many different reasons people have for buying flowers.",
			"Someone came in asking for an arrangement that reminded them of home.",
			"I had no idea what to make at first!",
			"But then I thought about what they described and came up with something.",
			"They absolutely loved it!",
			"Now I've been thinking about how flowers can mean totally different things to different people.",
			"It's kind of amazing, honestly. Every bouquet gets its own little story."
		],
		"shy": [
			"Um... I work at a flower shop. I make arrangements for people.",
			"Someone asked me to make something that reminded them of home.",
			"I wasn't sure what they meant at first.",
			"But I tried.",
			"They liked it. A lot.",
			"Now I think I understand what they were trying to say.",
			"I guess flowers can say things that are hard to explain."
		],
		"blunt": [
			"I'm a florist. People buy flowers for all kinds of reasons.",
			"Someone wanted an arrangement that reminded them of home.",
			"I made one.",
			"They liked it.",
			"They came back later.",
			"I've been thinking about it since.",
			"Turns out flowers mean more to people than they look like they do."
		],
		"chatty": [
			"I work at a flower shop! Someone came in today asking for something that reminded them of home, which sounds simple until you realize that's an incredibly difficult thing to put into a bouquet.",
			"I kept thinking about what they said while I worked.",
			"Eventually I picked out an arrangement that just felt right.",
			"They came back later and told me it reminded them exactly of where they grew up!",
			"I was honestly shocked that I got that close.",
			"Now I keep wondering how many other people are carrying around memories they could never quite put into words.",
			"Maybe that's what I like about flowers. They can do a little of that work for you."
		],
		"tired": [
			"I'm a florist... people ask for flowers for all kinds of reasons.",
			"Someone wanted an arrangement that reminded them of home.",
			"Wasn't easy to figure out.",
			"I managed.",
			"They liked it.",
			"They came back to tell me.",
			"I guess I did something right."
		]
	},

	"mechanic": {
		"polite": [
			"I work as a mechanic. Most of my days involve solving one problem after another.",
			"We had an older car come in recently. It needed more work than we first expected.",
			"I decided to take some extra time with it rather than rushing the repair.",
			"We finally found the real problem today.",
			"It took a while, but we managed to get everything working again.",
			"The owner came back to pick it up and seemed genuinely relieved.",
			"I suppose that's what keeps me enjoying the job. Sometimes you get to give someone their day back."
		],
		"cheerful": [
			"I'm a mechanic! We had an old car come in, and it was a complete mess.",
			"I thought the repair would take forever.",
			"But then I finally figured out what was actually wrong!",
			"It took some work, but we got it running again.",
			"The owner picked it up today and was absolutely thrilled.",
			"They said they'd almost given up on the car.",
			"I don't know, there's just something really satisfying about bringing something back to life."
		],
		"shy": [
			"Um... I'm a mechanic. I mostly work quietly.",
			"An old car came into the shop recently. It had a lot of problems.",
			"I wasn't sure we'd be able to fix it.",
			"But I kept working on it.",
			"We finally figured it out today.",
			"The owner was really happy.",
			"I think that's probably my favorite part of the job."
		],
		"blunt": [
			"I'm a mechanic. Cars break. I fix them.",
			"We got an old one in recently.",
			"Thought it was finished.",
			"Wasn't.",
			"Found the problem.",
			"Got it running.",
			"Owner was happy. That's enough."
		],
		"chatty": [
			"I'm a mechanic! An old car came into the shop recently, and at first we thought it had one problem.",
			"Then we found another.",
			"Then another.",
			"At that point I was convinced we'd never get it running again.",
			"But I kept poking around and eventually figured out what was actually happening.",
			"We got it working today, and the owner was so relieved that it honestly made the whole headache worth it.",
			"I guess that's the thing about repairing stuff. Sometimes you just have to keep looking until something finally makes sense."
		],
		"tired": [
			"I'm a mechanic... got an old car in the shop recently.",
			"Thought it would be a quick repair.",
			"It wasn't.",
			"Found the real problem eventually.",
			"Got it working today.",
			"The owner was happy.",
			"Good enough for me. I'm going home."
		]
	},

	"artist": {
		"polite": [
			"I'm an artist. I've been working on a piece for quite some time now.",
			"I've made several changes to it already. I'm still not certain it's finished.",
			"Today I finally decided to stop changing things and just leave it alone for a while.",
			"Looking at it again later made me notice something I hadn't seen before.",
			"I think I was trying too hard to make it perfect.",
			"I've started allowing myself to make smaller, simpler choices.",
			"The work feels much more like mine now."
		],
		"cheerful": [
			"I'm an artist! I've been working on one piece forever.",
			"I kept changing it because I couldn't decide when it was finished.",
			"Today I finally stepped away from it.",
			"When I looked again, I realized I actually liked parts of it!",
			"I think I was trying way too hard to make everything perfect.",
			"Now I'm letting myself experiment more.",
			"It feels way more fun when I stop worrying about whether every little thing is right."
		],
		"shy": [
			"Um... I'm an artist. I've been working on something for a while.",
			"I kept changing it because I didn't think it was good enough.",
			"Today I finally stopped.",
			"When I looked at it later... I actually liked it.",
			"I think maybe I was being too hard on myself.",
			"So I've been trying to just make things without judging them immediately.",
			"It's... kind of nice."
		],
		"blunt": [
			"I'm an artist. I've been working on the same piece for too long.",
			"Kept changing it.",
			"Eventually I stopped.",
			"Looked at it again later.",
			"It was fine.",
			"Maybe I was overthinking it.",
			"Trying not to do that anymore."
		],
		"chatty": [
			"I'm an artist! I've been working on the same piece for what feels like forever, because I kept finding tiny things I wanted to change.",
			"And every time I fixed one thing, I found another.",
			"Eventually I realized I wasn't even making the piece better anymore, just different.",
			"So I left it alone for a day.",
			"When I came back, I actually liked it!",
			"Now I'm trying to stop myself from immediately picking everything apart.",
			"Which is much harder than it sounds, by the way."
		],
		"tired": [
			"I'm an artist... I've been stuck on the same piece.",
			"Kept changing it.",
			"Then I stopped.",
			"Looked at it later.",
			"Wasn't as bad as I thought.",
			"So I'm leaving it alone for now.",
			"Probably better that way."
		]
	},

	"officeworker": {
		"polite": [
			"I work in an office. Most days are fairly routine, though there are occasional surprises.",
			"I've been given a project recently that is rather more complicated than expected.",
			"I've spent quite a bit of time trying to organize everything properly.",
			"I finally found a system that seems to be working.",
			"My coworkers have started using it too, which was unexpected.",
			"It's made things noticeably easier for everyone.",
			"I suppose even small changes can make a dull routine feel a little better."
		],
		"cheerful": [
			"I work in an office! I got handed this huge project recently and thought it was going to be awful.",
			"I started organizing everything little by little.",
			"Then I found a system that actually worked!",
			"My coworkers started using it too.",
			"Now everything is way less chaotic.",
			"People have actually been thanking me for it!",
			"I never thought I'd say this, but I kind of enjoy solving office problems now."
		],
		"shy": [
			"Um... I work in an office. It's mostly paperwork and computers.",
			"I've been working on a project that was getting pretty messy.",
			"I thought I was the only one having trouble with it.",
			"So I tried organizing it differently.",
			"It actually helped.",
			"Now some of my coworkers are using the same system.",
			"I guess I did something useful."
		],
		"blunt": [
			"I work in an office. Mostly emails and spreadsheets.",
			"I got stuck with a messy project.",
			"Organized it.",
			"Worked better.",
			"Other people copied it.",
			"Now everyone's less confused.",
			"Fine by me."
		],
		"chatty": [
			"I work in an office! I got assigned this enormous project, and at first it was just a mountain of files, emails, and completely unrelated notes.",
			"I spent ages trying to figure out how everything was connected.",
			"Eventually I made a system for organizing it.",
			"And then one coworker started using it.",
			"Then another.",
			"Now half the office is using this thing I made because they somehow think I'm organized.",
			"It's honestly pretty funny, considering how much of a mess my own desk is."
		],
		"tired": [
			"I work in an office... got handed a huge project recently.",
			"It was a mess.",
			"Organized it.",
			"Worked better.",
			"Other people started using it.",
			"Now they keep asking me questions about it.",
			"So I guess I accidentally made more work for myself."
		]
	}
}


var hobby_secret_dialogue_templates : Dictionary = {
	"gardening": {
		"polite": [
			"I've been caring for a few plants lately. It's become a pleasant way to unwind.",
			"One of them has started growing much faster than I expected.",
			"I've been paying closer attention to it lately. I think it may need a little more space.",
			"I moved it to a better spot today, and it already seems happier there.",
			"Another plant has started growing beside it. I hadn't noticed the little sprout before.",
			"I've become rather attached to the whole collection now.",
			"I suppose that's the funny thing about growing things. You start with one, and suddenly you have a little world to look after."
		],
		"cheerful": [
			"I've been growing a few plants at home! One of them finally sprouted!",
			"It's growing so quickly now that I keep checking it every morning.",
			"I realized it was getting cramped, so I moved it somewhere with more room.",
			"It started looking healthier almost immediately!",
			"And then I found another tiny sprout in the same pot!",
			"Now I'm completely invested in keeping both of them alive.",
			"I started with one plant. I have no idea how this turned into a whole little garden."
		],
		"shy": [
			"Um... I like taking care of plants. It's nice having something quiet to look after.",
			"One of mine has been growing a little lately.",
			"I think it needed a different spot, so I moved it.",
			"It seems happier now.",
			"Then I noticed another little sprout.",
			"I've been checking on it every morning.",
			"I know it's silly, but... I think taking care of them makes me happy."
		],
		"blunt": [
			"I grow plants. Started with one.",
			"It grew.",
			"Had to move it.",
			"That helped.",
			"Found another sprout.",
			"So now I have two.",
			"Apparently that's how this starts."
		],
		"chatty": [
			"I've been gardening lately! I started with one plant because I thought it'd be easy.",
			"Then it started growing faster than I expected.",
			"So I moved it, and immediately started worrying that I'd done something wrong.",
			"Thankfully, it seems to like the new spot.",
			"And then I found this tiny little sprout growing right beside it!",
			"Now I'm checking the soil every morning like some kind of plant detective.",
			"I told myself I wasn't going to become one of those people with a house full of plants, and yet here we are."
		],
		"tired": [
			"I've been taking care of some plants...",
			"One started growing.",
			"Had to move it.",
			"It seems fine now.",
			"Found another sprout.",
			"So now there's another one to worry about.",
			"I guess I don't mind."
		]
	},

	"reading": {
		"polite": [
			"I've been reading a new book lately. It's been a pleasant way to spend my evenings.",
			"I'm about halfway through now. The story has become rather more interesting.",
			"I've started thinking about the characters even when I'm not reading.",
			"I reached a particularly surprising chapter last night.",
			"I had to put the book down afterward and think about what had happened.",
			"I've recommended it to a friend, though I tried not to give anything away.",
			"They've started reading it too. Now we keep finding excuses to discuss it."
		],
		"cheerful": [
			"I found a really good book recently!",
			"I'm halfway through and it's getting SO good.",
			"I keep thinking about the characters when I'm not even reading.",
			"I hit a huge twist last night and just stared at the page for a minute.",
			"I immediately wanted to tell someone about it, but I didn't want to spoil anything.",
			"I convinced a friend to read it too!",
			"Now we keep talking about our favorite parts. It's become our little thing."
		],
		"shy": [
			"Um... I've been reading a book lately. I really like it.",
			"It's getting more interesting now.",
			"I keep thinking about it when I'm not reading.",
			"Something surprising happened last night.",
			"I wanted to tell someone about it, but I didn't want to spoil anything.",
			"I finally convinced a friend to read it too.",
			"It's nice having someone to talk about it with."
		],
		"blunt": [
			"Started a book recently.",
			"It's good.",
			"Getting better.",
			"Hit a big twist.",
			"Didn't see it coming.",
			"Got someone else to read it.",
			"Now we argue about it."
		],
		"chatty": [
			"I've been reading this book lately, and it started off pretty normally.",
			"Then it got more interesting.",
			"Then I started thinking about it when I wasn't even reading.",
			"Then there was this huge twist and I nearly dropped the book.",
			"I wanted to tell someone immediately, but I couldn't because spoilers.",
			"So I convinced a friend to read it instead.",
			"Now we've basically turned the whole thing into a weekly discussion, which is honestly almost as fun as the book."
		],
		"tired": [
			"I've been reading a book lately...",
			"It's pretty good.",
			"Got more interesting.",
			"Then there was a twist.",
			"Didn't expect it.",
			"Convinced someone else to read it.",
			"Now they keep asking me what happens next."
		]
	},

	"photography": {
		"polite": [
			"I've been enjoying photography lately. I like keeping little moments that might otherwise be forgotten.",
			"I've started carrying my camera with me more often.",
			"I've noticed I pay much more attention to my surroundings when I have it with me.",
			"I caught a rather beautiful moment by accident the other day.",
			"It wasn't planned at all, which made it feel more meaningful.",
			"I've started taking fewer pictures and waiting longer for the right moment.",
			"I think I'm finally learning that the best photograph isn't always the most carefully planned one."
		],
		"cheerful": [
			"I've been taking pictures everywhere lately!",
			"I started bringing my camera with me even when I don't have plans to use it.",
			"Now I keep noticing little things I would've ignored before.",
			"I got this amazing picture completely by accident!",
			"I wasn't even trying to take it.",
			"Now I'm trying to stop chasing perfect pictures and just pay attention.",
			"I think that's made photography way more fun for me."
		],
		"shy": [
			"Um... I like taking pictures. I've been bringing my camera with me more lately.",
			"I've started noticing things I used to walk right past.",
			"I took a picture by accident the other day.",
			"I actually really liked it.",
			"So now I'm trying not to plan everything.",
			"I just wait and see what catches my attention.",
			"It feels less scary that way."
		],
		"blunt": [
			"I take pictures.",
			"Started carrying my camera everywhere.",
			"Notice more things now.",
			"Got a good picture by accident.",
			"Liked it.",
			"So I stopped forcing everything.",
			"Works better."
		],
		"chatty": [
			"I've been taking my camera everywhere lately, even when I don't expect to use it.",
			"And now I've started noticing all these tiny details I used to completely miss.",
			"I took this one picture by accident because I wasn't even looking through the camera properly.",
			"And somehow it ended up being one of my favorites.",
			"That made me realize how much I was trying to control every picture.",
			"So now I'm experimenting with just waiting and seeing what happens.",
			"It's actually made me enjoy the hobby a lot more."
		],
		"tired": [
			"I've been carrying my camera around more.",
			"Started noticing more things.",
			"Got a good picture by accident.",
			"Didn't even mean to.",
			"Liked it.",
			"So now I'm taking fewer pictures.",
			"Mostly just waiting."
		]
	},

	"baking": {
		"polite": [
			"I've been baking more lately. It's a nice way to spend a quiet afternoon.",
			"I've been trying a few recipes I've never made before.",
			"One of them turned out rather poorly the first time.",
			"I made some adjustments and tried it again.",
			"The second attempt was much better.",
			"I've started bringing some of the results to people I know.",
			"They've been encouraging me to keep experimenting."
		],
		"cheerful": [
			"I've been baking a TON lately!",
			"I've been trying recipes I've never made before.",
			"One of them went horribly the first time.",
			"But I figured out what went wrong!",
			"The second attempt was SO much better.",
			"I started giving some to friends, and now they keep asking when I'm baking again.",
			"I may have accidentally created a group of people who expect free desserts from me."
		],
		"shy": [
			"Um... I've been baking more lately.",
			"I've been trying some recipes I haven't made before.",
			"One was a disaster the first time.",
			"I tried again, though.",
			"It came out better.",
			"I gave some to a few people.",
			"They liked it.",
			"I think I'd like to keep trying new things."
		],
		"blunt": [
			"I've been baking more.",
			"Tried a new recipe.",
			"Failed.",
			"Tried again.",
			"Worked.",
			"Gave some away.",
			"They wanted more.",
			"Now I have to bake again."
		],
		"chatty": [
			"I've been baking a lot lately! I decided to start trying recipes I'd never made before.",
			"Which sounded like a good idea until the first one completely fell apart.",
			"I spent ages figuring out what I'd done wrong.",
			"Then I tried again.",
			"And it actually worked!",
			"I gave some to friends, and now they've all decided I'm responsible for providing desserts whenever we hang out.",
			"Which is annoying... except I secretly kind of love it."
		],
		"tired": [
			"I've been baking more...",
			"Tried a new recipe.",
			"Failed.",
			"Tried again.",
			"Worked better.",
			"Gave some away.",
			"Now people want more. Of course."
		]
	},

	"drawing": {
		"polite": [
			"I've been drawing more lately. It's a pleasant way to spend some quiet time.",
			"I started keeping a small sketchbook with me.",
			"I've been filling it with little drawings whenever something catches my attention.",
			"Some of them are rather poor, but a few have surprised me.",
			"I've started keeping the imperfect ones instead of throwing them away.",
			"They make the better drawings feel more meaningful.",
			"I think I'm finally learning to enjoy drawing without needing every page to be good."
		],
		"cheerful": [
			"I've been drawing everywhere lately!",
			"I started carrying a little sketchbook around.",
			"Now I draw whenever I notice something interesting.",
			"Some of the sketches are TERRIBLE, but a few came out really well!",
			"I used to throw away the bad ones.",
			"Now I'm keeping them all.",
			"It's actually kind of fun seeing how much better they get over time."
		],
		"shy": [
			"Um... I've been drawing more lately.",
			"I started carrying a sketchbook with me.",
			"I draw little things whenever I notice them.",
			"Some of them aren't very good.",
			"I used to throw those away.",
			"But I've started keeping them.",
			"It's nice seeing the old ones after I've improved."
		],
		"blunt": [
			"I draw.",
			"Started carrying a sketchbook.",
			"Draw whatever I notice.",
			"Some of it is bad.",
			"Used to throw it away.",
			"Stopped doing that.",
			"Probably better for me."
		],
		"chatty": [
			"I've been carrying a sketchbook around lately, which has turned into a much bigger thing than I expected.",
			"I keep drawing little things whenever I notice them.",
			"Some sketches are genuinely awful.",
			"I used to immediately tear those pages out.",
			"Then I realized I kind of liked seeing the old ones later.",
			"They show me things I would've forgotten.",
			"So now I keep everything, even the embarrassing drawings. It's actually pretty freeing."
		],
		"tired": [
			"I've been drawing more.",
			"Started carrying a sketchbook.",
			"Some drawings are good.",
			"Some aren't.",
			"Used to throw the bad ones away.",
			"Don't anymore.",
			"Less effort that way."
		]
	},

	"music": {
		"polite": [
			"I listen to quite a lot of music. It's become part of my usual routine.",
			"I've recently started exploring artists I hadn't heard before.",
			"One of them caught my attention much more than I expected.",
			"I've been listening through more of their work ever since.",
			"I've even found a few songs I think I'll keep coming back to.",
			"I shared some of them with a friend, and they've been exploring them too.",
			"It's nice having something small to discover and share with someone."
		],
		"cheerful": [
			"I've been listening to SO much music lately!",
			"I started finding new artists and now I keep discovering more.",
			"I found one that I absolutely love.",
			"I've been listening to their whole catalog!",
			"I sent a few songs to a friend too.",
			"Now they're sending me recommendations back!",
			"We've basically made this giant shared playlist without even meaning to."
		],
		"shy": [
			"Um... I listen to music a lot.",
			"I've been trying to find new artists lately.",
			"I found one I really like.",
			"I've been listening to them quite a bit.",
			"I sent a song to a friend.",
			"They sent one back.",
			"Now we keep sharing songs with each other."
		],
		"blunt": [
			"I listen to music. A lot.",
			"Started looking for new artists.",
			"Found one I like.",
			"Found more songs.",
			"Sent one to a friend.",
			"They sent one back.",
			"Now we're trading recommendations."
		],
		"chatty": [
			"I've been listening to music a lot lately, and I decided I needed to find some new artists.",
			"One recommendation led to another, and then another.",
			"Eventually I found someone whose music I absolutely loved.",
			"So obviously I listened to everything they'd ever made.",
			"Then I sent a few songs to a friend.",
			"And they sent some back.",
			"Now we've basically created this giant chain of music recommendations, and I have no idea where it's going to end."
		],
		"tired": [
			"I've been listening to more music lately.",
			"Found a new artist.",
			"Liked them.",
			"Found more songs.",
			"Sent one to a friend.",
			"They sent one back.",
			"Now I have another playlist to deal with."
		]
	}
}

var customer_names : Array = [
	"Alice",
	"Mara",
	"Nora",
	"Iris",
	"Lena",
	"Maya",
	"June",
	"Clara",
	"Hazel",
	"Lucy",
	"Elise",
	"Ruby",
	"Vera",
	"Wren",
	"Mina",
	"Tessa",
	"Naomi",
	"Sadie",
	"Cora",
	"Mae",
	"Lydia",
	"Rose",
	"Daisy",
	"Faye",
	"Mabel",
	"Anna",
	"Leah",
	"Nina",
	"Eva",
	"Sylvie",
	"Elliot",
	"Theo",
	"Miles",
	"Noah",
	"Leo",
	"Sam",
	"Julian",
	"Caleb",
	"Owen",
	"Henry",
	"Felix",
	"Arthur",
	"Evan",
	"Simon",
	"Adrian",
	"Jonah",
	"Luca",
	"Oscar",
	"Eli",
	"Max",
	"Ben",
	"Finn",
	"Dean",
	"Lucas",
	"Rowan",
	"Jasper",
	"Micah",
	"Nico",
	"Aaron",
	"Dylan",
	"Alex",
	"Jamie",
	"Casey",
	"Morgan",
	"Riley",
	"Avery",
	"Jordan",
	"Taylor",
	"Quinn",
	"Reese",
	"Cameron",
	"Parker",
	"Emery",
	"Sage",
	"Robin",
	"Charlie",
	"Drew",
	"Blair",
	"Hayden",
	"Skyler",
	"River",
	"Arden",
	"Ellis",
	"Remy",
	"Finley",
	"Shiloh",
	"Marlowe",
	"Kit",
	"Lane"
]

var typical_dialogue : Array = [
	"Thanks!",
	"Thank you!",
	"Thanks, I appreciate it.",
	"Much appreciated!",
	"Thanks a bunch!",
	"Thank you so much.",
	"Perfect, thanks!",
	"Awesome, thanks!",
	"Looks great!",
	"That looks good.",
	"Exactly what I wanted.",
	"Yep, that'll do.",
	"Perfect.",
	"Great, thank you.",
	"Awesome.",
	"Nice!",
	"Sweet, thanks!",
	"That's perfect.",
	"Looks good to me.",
	"Smells great.",
	"That smells really good.",
	"Oh, nice.",
	"Lovely, thanks.",
	"Great!",
	"Thanks for that.",
	"Appreciate it.",
	"Thanks, have a good one.",
	"Thank you, you too.",
	"Alright, thanks!",
	"Okay, thank you.",
	"Yep, thanks.",
	"Got it, thanks.",
	"Cool, thanks.",
	"Alright, that'll be all.",
	"I think that's everything.",
	"That's it for me.",
	"Yeah, that'll do.",
	"I'll take it.",
	"Looks perfect.",
	"Very nice.",
	"Just what I needed.",
	"Can't complain.",
	"Not bad!",
	"Nice work.",
	"Looks delicious.",
	"Smells wonderful.",
	"Ooh, nice.",
	"Haha, thanks.",
	"Thanks again.",
	"Alright, have a good day.",
	"Thanks, take care.",
	"See you around.",
	"Bye!",
	"Have a good one!",
	"Take care!",
	"Alright, later.",
	"Thanks!",
	"Yep.",
	"Yeah.",
	"Sure thing.",
	"Mm-hm.",
	"Alright.",
	"Okay.",
	"I guess that'll work.",
	"That should be good.",
	"I think we're good.",
	"Yeah, sure.",
	"Sounds good.",
	"Works for me.",
	"That's fine.",
	"Alrighty.",
	"Well, thanks.",
	"Okay then.",
	"Cool.",
	"Nice.",
	"Great."
]




var current_ingredient : INGREDIENTS = INGREDIENTS.NONE
var current_type : TYPES = TYPES.TEA
var current_customer : Node2D = null
var money : int = 1000
var unlocked_ingredients : Array[INGREDIENTS] = [
	INGREDIENTS.MATCHA,
	INGREDIENTS.CHAMOMILE,
	INGREDIENTS.OOLONG,
	INGREDIENTS.SUGAR,
	INGREDIENTS.HONEY,
	INGREDIENTS.MAPLESYRUP,
	INGREDIENTS.LEMON,
	INGREDIENTS.MILK,
	INGREDIENTS.CINNAMON
]
var saved_customers : Array = [
	
]
var customer_queue : Array = [
	
]
