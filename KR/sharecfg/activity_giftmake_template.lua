pg = pg or {}
pg.activity_giftmake_template = {
	{
		reward = 900028,
		describe = "전에 섬에서 발견했던 흥미로운 재료로 라피의 머리핀을 만들어 보세요.\n머리핀의 스타일은… 라피가 좋아하는 토끼 귀 모양으로 만들어주면 라피가 정말 좋아할 것 같아요.",
		thankwords = "이건... 지휘관이 라피를 위해 직접 만든 거야? 반짝반짝 빛나는 루비가 토끼 눈 같아.\n어때, 잘 어울려? 흐응, 지휘관의 선물을 받아서 정말 기쁘지만 라피는 토끼가 아니라구!\n이건 지휘관한테 주는 답례 선물이야. 그리고, 이따 라피랑 같이 일광욕 즐기러 가줘야 해.",
		resources = "lafei",
		reward_describe = "라피의 답례 선물",
		id = 1,
		words = "어라? 갑자기 라피를 불러내다니, 지휘관... 설마 몰래 라피를 데리고 놀러 갈 생각인 거야?\n 라피에게 줄 선물이 있다고? 뭔데? 맛있는 디저트? 푹신푹신한 베개...? 얼른 알려줘.\n특별한 선물 상자까지 준비했다고? 라피는 아무 것도 기대 안했어... 응, 정말이야.",
		consume = {
			1002,
			6,
			10
		},
		reward_display = {
			{
				2,
				42040,
				2
			},
			{
				2,
				15014,
				1
			},
			{
				2,
				61001,
				2
			}
		},
		scaling = {
			0.5,
			0.5
		}
	},
	{
		reward = 900028,
		describe = "섬에서 반짝이는 보석을 발견했습니다. 보석처럼 반짝이는 재블린을 위해 그녀의 개성에 어울리는 무기를 만들어주는 건 어떨까요?\n섬에서 더 많이 수집해 그녀에게 서프라이즈를 선사해 보세요.",
		thankwords = "우와~ 반짝이는 루비가 박힌 투창 모형이네요~! 무기 모형이지만 엄청 정교해 보여요~ 헤헤, 지휘관, 감사합니다~\n잠시만요, 재블린도 지휘관을 위한 답례품을 준비했답니다——짜잔! 어서 받아주세요, 지휘관~",
		resources = "biaoqiang",
		reward_describe = "재블린의 답례 선물",
		id = 2,
		words = "지휘관, 갑자기 재블린을 혼자 부르다니, 서, 설마... 에에, 재블린한테 줄 선물이 있다구요? 뭔데요, 너무 기대돼요~!\n맞춰볼게요... 맛있는 음식? 예쁜 장식품? 전부 아니라구요? 흐음, 그럼 대체 뭘까나~",
		consume = {
			1002,
			6,
			10
		},
		reward_display = {
			{
				2,
				42040,
				2
			},
			{
				2,
				15014,
				1
			},
			{
				2,
				61001,
				2
			}
		},
		scaling = {
			0.3,
			0.3
		}
	},
	{
		reward = 900028,
		describe = "섬을 돌아다니다가 검술을 연습을 하고 있는{namecode:6} 발견... 섬에서 새로 발견한 재료로 '멋진 무기를 만들고 싶다'는 그녀의 소원을 들어주세요.",
		thankwords = "오오, 이 칼... 엄청 멋져 보이네요!\n매우 희귀한 장비처럼 보여요... {namecode:6}, 새로운 기술에 대한 영감을 얻은 것 같아요!\n{namecode:6}이(가) 지휘관에게 주는 답례 선물이니까, 이 재료를 받아주세요!",
		resources = "linbo",
		reward_describe = "아야나미의 답례 선물",
		id = 3,
		words = "좋은 아침입니다, 지휘관님. 마침 최근에 새로운 기술을 연마하고 있었거든요... 같이 연습하실래요?\n...에, {namecode:6}에게 깜짝 선물을 주고 싶다구요? ...새로 출시된 게임인가요? 아님 새로 나온 피규어? 흐음... {namecode:6}은(는) 정말 모르겠어요.",
		consume = {
			1002,
			6,
			10
		},
		reward_display = {
			{
				2,
				42040,
				2
			},
			{
				2,
				15014,
				1
			},
			{
				2,
				61001,
				2
			}
		},
		scaling = {
			0.35,
			0.35
		}
	},
	{
		reward = 900028,
		describe = "무인도에 거점을 건설하기 위해 최전선에서 활약하며 많은 노력을 기울인 {namecode:408}\n집 모양의 기념품인 '트로피'를 선물하면 그녀가 좋아하겠죠?",
		thankwords = "이건... 거점의 축소 모형... 상당히 섬세해보이네요~ 지휘관님이 많이 신경쓴 게 보여요. 고마워요, 지휘관님!\n지휘관님을 위해 사용할만한 재료를 준비해봤어요. 답례 선물로 받아주세요.",
		resources = "z23",
		reward_describe = "{namecode:408}의 답례 선물",
		id = 4,
		words = "혹시 {namecode:408}에게 무슨 시킬 임무라도 있는 건가요? 최대한 빨리 끝내볼게요!\n그냥 기념품을 선물하려고 부른 거라구요? 무인도 건설을 지도하면서 이런 것까지 언제 준비하셨어요. 역시 지휘관님께 배워야 할 부분이 아직 많은 것 같네요...\n이게 바로 지휘관님이 저를 위해 준비한 기념품인가요? 도대체 뭘지 너무 궁금해요!",
		consume = {
			1002,
			6,
			10
		},
		reward_display = {
			{
				2,
				42040,
				2
			},
			{
				2,
				15014,
				1
			},
			{
				2,
				61001,
				2
			}
		},
		scaling = {
			0.4,
			0.4
		}
	},
	{
		reward = 900028,
		describe = "섬에서 발견한 보석으로 투명한 유쨩을 만들어보는 건 어떨까요? 유니콘에게 크리스탈 유쨩 모형은 무거우니, 조심하라고 당부하는 거 잊지 마세요~",
		thankwords = "크리스탈 유쨩 모형? 맑고 투명한데다 반짝이는 장식까지 있잖아? 유짱, 잘됐다. 새로운 친구가 생겼네?\n응, 유니콘도 마음에 들어~! 오빠가 유니콘에게 준 선물이니까, 소중히 간직할게...!\n유니콘도 오빠에게 선물을 준비했는데… 여기, 오빠가 유니콘의 선물을 좋아했으면 좋겠다~",
		resources = "dujiaoshou",
		reward_describe = "유니콘의 답례 선물",
		id = 5,
		words = "에? 유니콘에게 비밀스러운 얘길 해주려구 부른 거야, 오빠? 그건 뭐야?\n유니콘에게 줄 선물? 오빠, 고생했어…♪~ 벌써 포장을 뚫고 나온 뾰족한 뿔이 보이네~ 어떤 선물일까나~",
		consume = {
			1002,
			5,
			10
		},
		reward_display = {
			{
				2,
				42040,
				2
			},
			{
				2,
				15014,
				1
			},
			{
				2,
				61001,
				2
			}
		},
		scaling = {
			0.3,
			0.3
		}
	},
	{
		reward = 900028,
		describe = "누군가 소문을 흘렸는지 새러토가가 모두를 위해 선물을 준비하려는 계획을 알게 된 것 같아요…. 벌써 몇 번이나 기념품을 만들어 달라고 조르고 있네요.\n그녀에게 줄 선물로 귀엽고 실용적인 주방 세트는 어떨까요?",
		thankwords = "이건... 주방 세트? 토파즈로 만들었다구? 엄청 멋진데~? 고마워, 지휘관~!\n맞다, 지휘관한테 답례 선물 주는 걸 깜빡할 뻔 했네-받아~ 헤헤, 걱정마. 이번엔 장난 안쳤으니까.",
		resources = "salatuojia",
		reward_describe = "새러토가 답례 선물",
		id = 6,
		words = "안녕, 지휘관~! 아침 일찍 나가는 거 다 봤다구~ 혹시 소문으로 듣던 선물을 준비하러 나간 거야?\n앗, 지휘관 손에 있는 물건 다 봤어~! 헤헤, 이 예민한 새러토가에게 지휘관의 마음을 숨길 생각 말라구? 어서 몸 뒤에 숨긴 선물 이리줘~!",
		consume = {
			1002,
			5,
			10
		},
		reward_display = {
			{
				2,
				42040,
				2
			},
			{
				2,
				15014,
				1
			},
			{
				2,
				61001,
				2
			}
		},
		scaling = {
			0.35,
			0.35
		}
	},
	{
		reward = 900028,
		describe = "거점 건설 과정에서 많은 도움을 준 {namecode:98}에게 감사의 표시로 선물을 해보세요.\n{namecode:98}의 경우, 그녀가 가장 좋아하는 것은 당연히 그거겠죠…?",
		thankwords = "냥?! 이 상자... 화려해 보이는 예쁜 보물상자자냥~ 위에 루비와 토파즈까지 있으니, 귀중품을 담기에 더할 나위 없이 좋겠다옹~\n이렇게 된 이상, {namecode:98}의 감사의 마음을 담은 이 답례 선물을 지휘관에게 주겠다옹~",
		resources = "mingshi",
		reward_describe = "{namecode:98}의 답례 선물",
		id = 7,
		words = "대화나 하자고 {namecode:98}를 불러내다니, 요즘 한가한 거냥? 그게 아니라면, {namecode:98}한테 주문할 물건이라도 있는 거냥?\n...{namecode:98}를 위해 준비한 선물이라구옹? 정말 예상 못한 서프라이즈다냥~! 손님인 지휘관이 {namecode:98}한테 선물까지 준비할 줄은 생각 못했어, 정말 감동이다옹~",
		consume = {
			1002,
			5,
			10
		},
		reward_display = {
			{
				2,
				42040,
				2
			},
			{
				2,
				15014,
				1
			},
			{
				2,
				61001,
				2
			}
		},
		scaling = {
			0.4,
			0.4
		}
	},
	{
		reward = 900028,
		describe = "섬에서 발견한 특이한 모양의 광석으로 비상하는 독수리 모형을 조각해 보세요. 거점 건설을 위해 고생한 엔터프라이즈에게 기념품으로 선물한다면, 엄청 좋아할 거예요.",
		thankwords = "토파즈로 만든 독수리 모형? 하늘 높이 비상하는 모습이 매우 멋진데? 직접 만든 거라구? 정말 대단하네... 후후, 마음에 들어\n선물 고마워. 자, 이건 답례품이야.",
		resources = "qiye",
		reward_describe = "엔터프라이즈의 답례 선물",
		id = 8,
		words = "왔네, 무슨 처리해야 할 업무라도 있는 거야? 아니야...? 하하, 그럼 나와 같이 쉬려고 온 거야? 잠시 내려놓고 휴식을 취하는 것도 좋지\n… 나한테 보여줄 물건이 있다고?",
		consume = {
			1002,
			5,
			10
		},
		reward_display = {
			{
				2,
				42040,
				2
			},
			{
				2,
				15014,
				1
			},
			{
				2,
				61001,
				2
			}
		},
		scaling = {
			0.35,
			0.35
		}
	}
}
