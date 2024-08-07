return {
	map_id = 10001,
	id = 1755002,
	stages = {
		{
			stageIndex = 1,
			failCondition = 1,
			timeCount = 300,
			backGroundStageID = 1,
			passCondition = 1,
			totalArea = {
				-80,
				20,
				90,
				70
			},
			playerArea = {
				-80,
				20,
				45,
				68
			},
			enemyArea = {},
			fleetCorrdinate = {
				-80,
				0,
				75
			},
			waves = {
				{
					triggerType = 1,
					waveIndex = 100,
					preWaves = {},
					triggerParams = {
						timeout = 0.5
					}
				},
				{
					triggerType = 3,
					waveIndex = 500,
					preWaves = {
						100
					},
					triggerParams = {
						id = "XUYUWANGYUECHAO29-1"
					}
				},
				{
					triggerType = 0,
					key = true,
					waveIndex = 101,
					conditionType = 1,
					preWaves = {
						500
					},
					triggerParam = {},
					spawn = {
						{
							monsterTemplateID = 16556001,
							score = 0,
							delay = 0,
							moveCast = true,
							corrdinate = {
								10,
								0,
								75
							},
							buffList = {
								8001,
								8007
							}
						},
						{
							monsterTemplateID = 16556003,
							score = 0,
							delay = 0,
							moveCast = true,
							corrdinate = {
								0,
								0,
								55
							},
							buffList = {
								8001,
								8007
							}
						},
						{
							monsterTemplateID = 16556001,
							score = 0,
							delay = 0,
							moveCast = true,
							corrdinate = {
								10,
								0,
								35
							},
							buffList = {
								8001,
								8007
							}
						}
					}
				},
				{
					triggerType = 0,
					key = true,
					waveIndex = 102,
					conditionType = 1,
					preWaves = {
						101
					},
					triggerParam = {},
					spawn = {
						{
							monsterTemplateID = 16556002,
							score = 0,
							delay = 0,
							moveCast = true,
							corrdinate = {
								5,
								0,
								65
							},
							buffList = {
								8001,
								8007
							}
						},
						{
							monsterTemplateID = 16556003,
							score = 0,
							delay = 0,
							moveCast = true,
							corrdinate = {
								-5,
								0,
								55
							},
							buffList = {
								8001,
								8007
							}
						},
						{
							monsterTemplateID = 16556002,
							score = 0,
							delay = 0,
							moveCast = true,
							corrdinate = {
								5,
								0,
								35
							},
							buffList = {
								8001,
								8007
							}
						}
					}
				},
				{
					triggerType = 0,
					key = true,
					waveIndex = 103,
					conditionType = 1,
					preWaves = {
						102
					},
					triggerParam = {},
					spawn = {
						{
							monsterTemplateID = 16556001,
							score = 0,
							delay = 0,
							moveCast = true,
							corrdinate = {
								0,
								0,
								67
							},
							buffList = {
								8001,
								8007
							}
						},
						{
							monsterTemplateID = 16556003,
							score = 0,
							delay = 0,
							moveCast = true,
							corrdinate = {
								-5,
								0,
								80
							},
							buffList = {
								8001,
								8007
							}
						},
						{
							monsterTemplateID = 16556004,
							score = 0,
							delay = 0,
							moveCast = true,
							corrdinate = {
								-10,
								0,
								55
							},
							buffList = {
								8001,
								8007
							}
						},
						{
							monsterTemplateID = 16556003,
							score = 0,
							delay = 0,
							moveCast = true,
							corrdinate = {
								-5,
								0,
								30
							},
							buffList = {
								8001,
								8007
							}
						},
						{
							monsterTemplateID = 16556001,
							score = 0,
							delay = 0,
							moveCast = true,
							corrdinate = {
								0,
								0,
								43
							},
							buffList = {
								8001,
								8007
							}
						}
					}
				},
				{
					triggerType = 3,
					waveIndex = 501,
					preWaves = {
						103
					},
					triggerParams = {
						id = "XUYUWANGYUECHAO29-2"
					}
				},
				{
					triggerType = 0,
					key = true,
					waveIndex = 104,
					conditionType = 1,
					preWaves = {
						501
					},
					triggerParam = {},
					spawn = {
						{
							monsterTemplateID = 16556002,
							score = 0,
							delay = 0,
							moveCast = true,
							corrdinate = {
								5,
								0,
								75
							},
							buffList = {
								8001,
								8007
							}
						},
						{
							monsterTemplateID = 16556003,
							score = 0,
							delay = 0,
							moveCast = true,
							corrdinate = {
								-5,
								0,
								55
							},
							buffList = {
								8001,
								8007
							}
						},
						{
							monsterTemplateID = 16556002,
							score = 0,
							delay = 0,
							moveCast = true,
							corrdinate = {
								5,
								0,
								35
							},
							buffList = {
								8001,
								8007
							}
						}
					}
				},
				{
					triggerType = 0,
					key = true,
					waveIndex = 105,
					conditionType = 1,
					preWaves = {
						104
					},
					triggerParam = {},
					spawn = {
						{
							monsterTemplateID = 16556003,
							score = 0,
							delay = 0,
							moveCast = true,
							corrdinate = {
								-15,
								0,
								80
							},
							buffList = {
								8001,
								8007
							}
						},
						{
							monsterTemplateID = 16556004,
							score = 0,
							delay = 0,
							moveCast = true,
							corrdinate = {
								-5,
								0,
								40
							},
							buffList = {
								8001,
								8007
							}
						},
						{
							monsterTemplateID = 16556005,
							score = 0,
							delay = 0,
							moveCast = true,
							corrdinate = {
								-5,
								0,
								70
							},
							buffList = {
								8001,
								8007
							}
						},
						{
							monsterTemplateID = 16556003,
							score = 0,
							delay = 0,
							moveCast = true,
							corrdinate = {
								-15,
								0,
								30
							},
							buffList = {
								8001,
								8007
							}
						}
					}
				},
				{
					triggerType = 3,
					waveIndex = 502,
					preWaves = {
						105
					},
					triggerParams = {
						id = "XUYUWANGYUECHAO29-3"
					}
				},
				{
					triggerType = 5,
					waveIndex = 400,
					preWaves = {
						502
					},
					triggerParams = {
						bgm = "story-unzen-heart"
					}
				},
				{
					triggerType = 4,
					waveIndex = 106,
					preWaves = {
						502
					},
					triggerParams = {
						kill_list = {
							900402,
							900403
						}
					}
				},
				{
					triggerType = 0,
					key = true,
					waveIndex = 107,
					conditionType = 1,
					preWaves = {
						106
					},
					triggerParam = {},
					spawn = {
						{
							monsterTemplateID = 16556007,
							delay = 0,
							corrdinate = {
								-15,
								0,
								30
							},
							buffList = {},
							bossData = {
								hideBarNum = true,
								icon = "",
								hpBarNum = 2
							},
							phase = {
								{
									switchType = 1,
									switchTo = 21,
									index = 0,
									switchParam = 1.5,
									setAI = 20006
								},
								{
									switchType = 1,
									switchTo = 1,
									index = 21,
									switchParam = 11,
									addBuff = {
										200604
									}
								},
								{
									switchParam = 4,
									switchTo = 2,
									index = 1,
									switchType = 1,
									addWeapon = {
										3084001,
										3084002
									},
									removeWeapon = {}
								},
								{
									switchParam = 300,
									switchTo = 1,
									index = 2,
									switchType = 1,
									addWeapon = {},
									removeWeapon = {
										3084001,
										3084002
									}
								}
							}
						}
					}
				},
				{
					triggerType = 8,
					waveIndex = 900,
					preWaves = {
						107
					},
					triggerParams = {}
				},
				{
					triggerType = 1,
					waveIndex = 901,
					preWaves = {
						900
					},
					triggerParams = {
						timeout = 2
					}
				},
				{
					triggerType = 3,
					key = true,
					waveIndex = 503,
					preWaves = {
						901
					},
					triggerParams = {
						id = "XUYUWANGYUECHAO29-4"
					}
				}
			}
		}
	},
	fleet_prefab = {
		vanguard_unitList = {
			{
				level = 125,
				configId = 900404,
				skinId = 303190,
				tmpID = 900404,
				id = 1,
				energy = 10,
				equipment = {
					false,
					false,
					false
				},
				properties = {
					cannon = 700,
					reload = 600,
					luck = 99,
					torpedo = 500,
					durability = 80000,
					air = 0,
					dodge = 150,
					antiaircraft = 400,
					speed = 25,
					armor = 0,
					hit = 300
				},
				skills = {}
			},
			{
				level = 125,
				configId = 900403,
				skinId = 399060,
				tmpID = 900403,
				id = 2,
				energy = 10,
				equipment = {
					false,
					false,
					false
				},
				properties = {
					cannon = 340,
					reload = 1200,
					luck = 15,
					torpedo = 850,
					durability = 45000,
					air = 0,
					dodge = 200,
					antiaircraft = 400,
					speed = 34,
					armor = 0,
					hit = 320
				},
				skills = {
					{
						id = 19750,
						level = 10
					},
					{
						id = 19760,
						level = 10
					},
					{
						id = 19002,
						level = 10
					},
					{
						id = 30072,
						level = 10
					},
					{
						id = 200099,
						level = 10
					}
				}
			},
			{
				configId = 900402,
				level = 125,
				skinId = 399010,
				id = 3,
				tmpID = 900402,
				equipment = {
					false,
					false,
					false
				},
				properties = {
					cannon = 552,
					reload = 600,
					luck = 15,
					torpedo = 580,
					durability = 250000,
					air = 0,
					dodge = 180,
					antiaircraft = 400,
					speed = 28,
					armor = 0,
					hit = 280
				},
				skills = {
					{
						id = 19050,
						level = 10
					},
					{
						id = 19060,
						level = 10
					},
					{
						id = 19002,
						level = 10
					},
					{
						id = 29222,
						level = 10
					},
					{
						id = 200603,
						level = 10
					}
				}
			}
		}
	}
}
