return {
	map_id = 10001,
	id = 1784008,
	stages = {
		{
			stageIndex = 1,
			failCondition = 1,
			timeCount = 180,
			backGroundStageID = 1,
			passCondition = 1,
			totalArea = {
				-70,
				20,
				90,
				70
			},
			playerArea = {
				-70,
				20,
				37,
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
					triggerType = 1,
					waveIndex = 202,
					preWaves = {},
					triggerParams = {
						timeout = 18
					}
				},
				{
					triggerType = 1,
					waveIndex = 203,
					preWaves = {},
					triggerParams = {
						timeout = 33
					}
				},
				{
					triggerType = 1,
					waveIndex = 204,
					preWaves = {},
					triggerParams = {
						timeout = 44
					}
				},
				{
					triggerType = 0,
					key = true,
					waveIndex = 101,
					conditionType = 1,
					preWaves = {
						100
					},
					triggerParam = {},
					spawn = {
						{
							deadFX = "udf_shanshuo",
							sickness = 0.3,
							delay = 0,
							monsterTemplateID = 16584003,
							corrdinate = {
								-5,
								0,
								75
							},
							buffList = {
								8001,
								8007,
								200720,
								200721
							}
						},
						{
							deadFX = "udf_shanshuo",
							sickness = 0.3,
							delay = 0,
							monsterTemplateID = 16584002,
							corrdinate = {
								0,
								0,
								50
							},
							buffList = {
								8001,
								8007,
								200720,
								200721
							}
						},
						{
							deadFX = "udf_shanshuo",
							sickness = 0.3,
							delay = 0,
							monsterTemplateID = 16584003,
							corrdinate = {
								-5,
								0,
								25
							},
							buffList = {
								8001,
								8007,
								200720,
								200721
							}
						}
					},
					airFighter = {
						{
							interval = 5,
							onceNumber = 4,
							formation = 10006,
							templateID = 1007084,
							delay = 0,
							totalNumber = 8,
							weaponID = {
								1007094,
								1007099
							},
							attr = {
								airPower = 40,
								maxHP = 15,
								attackRating = 23
							}
						},
						{
							interval = 5,
							onceNumber = 2,
							formation = 10006,
							templateID = 1007089,
							delay = 0,
							totalNumber = 2,
							weaponID = {
								1007104,
								1007109
							},
							attr = {
								airPower = 40,
								maxHP = 15,
								attackRating = 23
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
						101,
						202
					},
					triggerParam = {},
					spawn = {
						{
							deadFX = "udf_shanshuo",
							sickness = 0.3,
							delay = 0.5,
							monsterTemplateID = 16584005,
							reinforceDelay = 6,
							corrdinate = {
								-5,
								0,
								50
							},
							buffList = {
								8001,
								8007,
								200720,
								200721
							}
						}
					},
					reinforcement = {
						{
							deadFX = "udf_shanshuo",
							sickness = 0.3,
							delay = 0,
							monsterTemplateID = 16584002,
							corrdinate = {
								-12,
								0,
								65
							},
							buffList = {
								8001,
								8007,
								200720,
								200721
							}
						},
						{
							deadFX = "udf_shanshuo",
							sickness = 0.3,
							delay = 0,
							monsterTemplateID = 16584002,
							corrdinate = {
								-12,
								0,
								35
							},
							buffList = {
								8001,
								8007,
								200720,
								200721
							}
						}
					}
				},
				{
					key = true,
					triggerType = 0,
					waveIndex = 103,
					conditionType = 0,
					preWaves = {
						102,
						101
					},
					triggerParam = {},
					spawn = {
						{
							deadFX = "udf_shanshuo",
							sickness = 0.3,
							delay = 0,
							monsterTemplateID = 16584005,
							reinforceDelay = 6,
							corrdinate = {
								-5,
								0,
								50
							},
							buffList = {
								8001,
								8007,
								200720,
								200721
							}
						}
					},
					reinforcement = {
						{
							deadFX = "udf_shanshuo",
							sickness = 0.3,
							delay = 0.5,
							monsterTemplateID = 16584001,
							corrdinate = {
								-12,
								0,
								75
							},
							buffList = {
								8001,
								8007,
								200720,
								200721
							}
						},
						{
							deadFX = "udf_shanshuo",
							sickness = 0.3,
							delay = 0,
							monsterTemplateID = 16584003,
							corrdinate = {
								-5,
								0,
								63
							},
							buffList = {
								8001,
								8007,
								200720,
								200721
							}
						},
						{
							deadFX = "udf_shanshuo",
							sickness = 0.3,
							delay = 0.5,
							monsterTemplateID = 16584001,
							corrdinate = {
								-12,
								0,
								25
							},
							buffList = {
								8001,
								8007,
								200720,
								200721
							}
						},
						{
							deadFX = "udf_shanshuo",
							sickness = 0.3,
							delay = 0,
							monsterTemplateID = 16584003,
							corrdinate = {
								-5,
								0,
								37
							},
							buffList = {
								8001,
								8007,
								200720,
								200721
							}
						}
					},
					airFighter = {
						{
							interval = 5,
							onceNumber = 4,
							formation = 10006,
							templateID = 1007084,
							delay = 0,
							totalNumber = 8,
							weaponID = {
								1007094,
								1007099
							},
							attr = {
								airPower = 40,
								maxHP = 15,
								attackRating = 23
							}
						},
						{
							interval = 5,
							onceNumber = 2,
							formation = 10006,
							templateID = 1007089,
							delay = 0,
							totalNumber = 2,
							weaponID = {
								1007104,
								1007109
							},
							attr = {
								airPower = 40,
								maxHP = 15,
								attackRating = 23
							}
						}
					}
				},
				{
					triggerType = 8,
					waveIndex = 900,
					preWaves = {
						103
					},
					triggerParams = {}
				}
			}
		}
	},
	fleet_prefab = {}
}
