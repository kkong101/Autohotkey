#include Gdip_All.ahk
#include Gdip_ImageSearch.ahk

CoordMode,Mouse,Client
CoordMode,Pixel,Client


global activated_window := "(aflhzv)"
global prev_resource_num := -1
global prev_resource_level := -1
global main_cycle_num:= 1
global MAIN_CYCLE_MAX_NUM := 7
global chaing_id_num := 1
global yaman_num := 1


NA_MouseClick(activated_window,x_pos,y_pos) {
	
    lparam := x_pos|y_pos<<16
    PostMessage,0x201,1,%lparam%,,%activated_window%
    Sleep,110
    PostMessage,0x202,0,%lparam%,,%activated_window%
	return
}

NA_ImageSearch(activated_window,image_path,start_x,start_y,end_x,end_y,variation) {

	pToken := Gdip_StartUp()

	pHaystack := Gdip_BitmapFromHWND(WinExist(activated_window))
	pNeedle := Gdip_CreateBitmapFromFile(image_path)
	
	result := Gdip_ImageSearch(pHaystack, pNeedle, outputVar, start_x, start_y, end_x, end_y, variation)
	
	
	if (result == 1) {
		
		
		Gdip_DisposeImage(pBitmapHayStack), Gdip_DisposeImage(pBitmapNeedle)
		Gdip_Shutdown(pToken)
		
		return outputVar
		
	} else {
		
		Gdip_DisposeImage(pBitmapHayStack), Gdip_DisposeImage(pBitmapNeedle)
		Gdip_Shutdown(pToken)
		return -1
	}
	
	
	

	return
}


NA_get_Xcoord(outputVar) {
	
	RegExMatch(outputVar, "(.*),(.*)", out)
	x_pos := out1 
	
	return x_pos
}

NA_get_Ycoord(outputVar) {
	
	RegExMatch(outputVar, "(.*),(.*)", out)
	y_pos := out2
	
	return y_pos
}

help_union(activated_window) {
    
        Sleep,1000
        if (check_isInCastle(activated_window) == 1) {
            outputVar := NA_ImageSearch(activated_window,"C:\Users\aflhz\images\연맹지원악수.bmp",140,140,850,490,90)
            if(outputVar != 1 and outputVar != -1) {
            x := NA_get_Xcoord(outputVar)
            y := NA_get_Ycoord(outputVar)
            NA_MouseClick(activated_window,x+20,y+20)
            Sleep,1000
            outputVar := NA_ImageSearch(activated_window,"C:\Users\aflhz\images\연맹지원악수.bmp",140,140,850,490,90)
            if(outputVar != 1 and outputVar != -1) {
                NA_MouseClick(activated_window,x+3,y+3)
            }
        }
    } else {
        
        return 
    }
    
    return
}


;~ ;성안에 있으면 1 반환, 밖에있으면 안으로 들어오고 1 환환, 아예 못찾으면 -1 반환
check_isInCastle(activated_window) {
    
     outputVar := NA_ImageSearch(activated_window,"C:\Users\aflhz\images\집안에있음2.bmp",5,480,90,570,125)
    if(outputVar != 1 and outputVar != -1) {
        return true
    }
    
    outputVar := NA_ImageSearch(activated_window,"C:\Users\aflhz\images\집안에있음3.bmp",5,480,90,570,125)
    if(outputVar != 1 and outputVar != -1) {
        return true
    }
    
    outputVar := NA_ImageSearch(activated_window,"C:\Users\aflhz\images\집안에있음5.bmp",5,480,90,570,130)
    if(outputVar != 1 and outputVar != -1) {
        return true
    } else {
        outputVar := NA_ImageSearch(activated_window,"C:\Users\aflhz\images\접속화면6.bmp",10,474,90,575,125)
        if(outputVar != 1 and outputVar != -1) {
            x := NA_get_Xcoord(outputVar)
            y := NA_get_Ycoord(outputVar)
            NA_MouseClick(activated_window,x+10,y+10)
            Sleep,1500
            return true
        }
    }
    
    outputVar := NA_ImageSearch(activated_window,"C:\Users\aflhz\images\접속화면.bmp",5,480,90,570,125)
    if(outputVar != 1 and outputVar != -1) {
        return true
    } else {
        outputVar := NA_ImageSearch(activated_window,"C:\Users\aflhz\images\접속화면2.bmp",10,474,90,575,125)
            if(outputVar != 1 and outputVar != -1) {
                x := NA_get_Xcoord(outputVar)
                y := NA_get_Ycoord(outputVar)
                NA_MouseClick(activated_window,x+10,y+10)
                Sleep,1500
                return true
            }
    }
    
    
    outputVar := NA_ImageSearch(activated_window,"C:\Users\aflhz\images\접속화면3.bmp",5,480,90,570,125)
    if(outputVar != 1 and outputVar != -1) {
        return true
    } else {
        outputVar := NA_ImageSearch(activated_window,"C:\Users\aflhz\images\접속화면4.bmp",10,474,90,575,125)
            if(outputVar != 1 and outputVar != -1) {
                x := NA_get_Xcoord(outputVar)
                y := NA_get_Ycoord(outputVar)
                NA_MouseClick(activated_window,x+10,y+10)
                Sleep,1500
                return true
            }
    }
    
    
    outputVar := NA_ImageSearch(activated_window,"C:\Users\aflhz\images\집안에있음.bmp",10,484,80,566,125)
    if(outputVar != 1 and outputVar != -1) {
        return true
    } else {
        outputVar := NA_ImageSearch(activated_window,"C:\Users\aflhz\images\집밖에있음.bmp",10,474,90,575,125)
            if(outputVar != 1 and outputVar != -1) {
                x := NA_get_Xcoord(outputVar)
                y := NA_get_Ycoord(outputVar)
                NA_MouseClick(activated_window,x+10,y+10)
                Sleep,1500
                return true
            }
    }
    
    
    
    return -1
}

get_resource_inCastle(activated_window) {
    if (check_isInCastle(activated_window) == 1) {
        
            outputVar := NA_ImageSearch(activated_window,"C:\Users\aflhz\images\도시옥수수.bmp",140,140,850,490,100)
            if(outputVar != 1 and outputVar != -1) {
                x := NA_get_Xcoord(outputVar)
                y := NA_get_Ycoord(outputVar)
                NA_MouseClick(activated_window,x+18,y+18)
                Sleep,1700
            }
            
            outputVar := NA_ImageSearch(activated_window,"C:\Users\aflhz\images\도시나무.bmp",140,140,850,490,90)
            if(outputVar != 1 and outputVar != -1) {
                x := NA_get_Xcoord(outputVar)
                y := NA_get_Ycoord(outputVar)
                NA_MouseClick(activated_window,x+20,y+20)
                Sleep,1700
            }
            
            outputVar := NA_ImageSearch(activated_window,"C:\Users\aflhz\images\도시돌.bmp",140,140,850,490,90)
            if(outputVar != 1 and outputVar != -1) {
                x := NA_get_Xcoord(outputVar)
                y := NA_get_Ycoord(outputVar)
                NA_MouseClick(activated_window,x+8,y+8)
				outputVar := NA_ImageSearch(activated_window,"C:\Users\aflhz\images\도시돌.bmp",140,140,850,490,90)
            if(outputVar != 1 and outputVar != -1) {
				x := NA_get_Xcoord(outputVar)
                y := NA_get_Ycoord(outputVar)
                NA_MouseClick(activated_window,x+20,y+20)
			}
				
                Sleep,1700
            }
            
            outputVar := NA_ImageSearch(activated_window,"C:\Users\aflhz\images\도시금.bmp",140,140,850,490,90)
            if(outputVar != 1 and outputVar != -1) {
                x := NA_get_Xcoord(outputVar)
                y := NA_get_Ycoord(outputVar)
                NA_MouseClick(activated_window,x+18,y+18)
                Sleep,1700
            }
        } else {
            ;에러처리
        }
    return
}


; true 면 풀병력 false 면 보낼병력 있음 
is_full_corps_outCastle(activated_window) {
    
    ;총 개방된 군사 수 먼저 찾고 그다음 나가있는 병사 탐색 
    if (check_isInCastle(activated_window) == 1) {
        outputVar := NA_ImageSearch(activated_window,"C:\Users\aflhz\images\부대체크숫자5.bmp",923,160,945,177,110)
            if(outputVar != 1 and outputVar != -1) {
                if (check_isInCastle(activated_window) == 1) {
                    outputVar := NA_ImageSearch(activated_window,"C:\Users\aflhz\images\부대체크숫자5.bmp",910,160,922,177,110)
                    if(outputVar != 1 and outputVar != -1) {
                        return true 
                    } else {
                        return false 
                    } 
                }
            } else {
                outputVar := NA_ImageSearch(activated_window,"C:\Users\aflhz\images\부대체크숫자4.bmp",923,160,945,177,110)
                if(outputVar != 1 and outputVar != -1) {
                    if (check_isInCastle(activated_window) == 1) {
                        outputVar := NA_ImageSearch(activated_window,"C:\Users\aflhz\images\부대체크숫자4.bmp",910,160,922,177,110)
                        if(outputVar != 1 and outputVar != -1) {
                            return true 
                        } else {
                            return false
                        } 
                    }
                } else {
                    ;병사 최대 3명 탐색 
                    outputVar := NA_ImageSearch(activated_window,"C:\Users\aflhz\images\부대체크숫자3.bmp",923,160,945,177,110)
                    if(outputVar != 1 and outputVar != -1) {
                        if (check_isInCastle(activated_window) == 1) {
                            outputVar := NA_ImageSearch(activated_window,"C:\Users\aflhz\images\부대체크숫자3.bmp",910,160,922,177,110)
                            if(outputVar != 1 and outputVar != -1) {
                                return true 
                            } else {
                                return false
                            } 
                        }
                    } else {
                        return false
                    }
                }
                
            } 
    }

    return
}

goTo_resource(activated_window,levelup_num) {
    
    levelup_num := levelup_num - 1
    
    if (check_isInCastle(activated_window) == 1) {
        
        
        Random,randNum,1,8
        
            
		;이전에 자원을 뭐캤는지 탐색 
		if(prev_resource_num = 1 or 2) {
			
			if (randNum = 1 or 2) {
				Random,randNum,3,8
			}
			
		} else if (prev_resource_num = 3 or 4) {
                
                if (randNum = 3 or 4) {
                    
                    Random,randNum22,1,3
                    if (randNum22 = 1) {
                        Random,randNum,1,2
                    } else {
                        Random,randNum,5,8
                    }
                    
					
                }
                
            } else if ( prev_resource_num = 5) {
                
                if (randNum = 5) {
                    
                    Random,randNum22,1,2
                    if (randNum22 = 1) {
                        Random,randNum,1,4
                    } else {
                        Random,randNum,5,8
                    }
                    
                }

                
            } else if ( prev_resource_num = 6 or 7 or 8 ) {
                
                    if (randNum = 6 or 7 or 8) {
                        Random,randNum,1,5
					}
            
            } 
            
        prev_resource_num := randNum
        
        Sleep,2000
        NA_MouseClick(activated_window,48,530) ;성나가기
        Sleep,2000
        NA_MouseClick(activated_window,44,440) ;돋보기 클릭
        Sleep,2000
        
        
        
        if(randNum = 1 or randNum = 2) {
            ;식량 
            NA_MouseClick(activated_window,336,516) ;식량클릭
            Sleep,1500
            
            ;레벨초기화
            loop, 6 {
                NA_MouseClick(activated_window,237,340)
                Sleep,100
            }
			
			Sleep,1000
            
            ;레벨업
            loop, %levelup_num% {
                NA_MouseClick(activated_window,441,339)
                Sleep,100
            }
            
            
            
        } else if (randNum = 4 or randNum = 3) {
            ;나무

            NA_MouseClick(activated_window,485,516) ;나무클릭
            Sleep,1500
            
            ;레벨초기화
            loop, 6 {
                NA_MouseClick(activated_window,378,340)
                Sleep,100
            }
			
			Sleep,1000
            
            ;레벨업
            loop, %levelup_num% {
                NA_MouseClick(activated_window,582,339)
                Sleep,100
            }
            
        
        } else if (randNum = 5) {
            ;돌

            NA_MouseClick(activated_window,622,516) ;돌클릭
            Sleep,1500
            
            ;레벨초기화
            loop, 6 {
                NA_MouseClick(activated_window,521,340)
                Sleep,70
            }
			
			Sleep,1000
            
            ;레벨업
            loop, %levelup_num% {
                NA_MouseClick(activated_window,726,339)
                Sleep,70
            }
            
            
        } else if (randNum = 6 or randNum = 7 or randNum = 8) {
            ;금

            NA_MouseClick(activated_window,761,516) ;금클릭
            Sleep,1500
            
            ;레벨초기화
            loop, 6 {
                NA_MouseClick(activated_window,665,340)
                Sleep,70
            }
			
			Sleep,1000
            
            ;레벨업
            loop, %levelup_num% {
                NA_MouseClick(activated_window,871,339)
                Sleep,70
            }
        }
		
		Sleep,2500
		
		hap2 := 1
		;검색 찾아서 클릭 
		loop {
			Sleep,1000
			
			outputVar := NA_ImageSearch(activated_window,"C:\Users\aflhz\images\검색2.bmp",260,370,830,430,100)
			if(outputVar != 1 and outputVar != -1) {
				x := NA_get_Xcoord(outputVar)
				y := NA_get_Ycoord(outputVar)
				NA_MouseClick(activated_window,x+15,y+15)
                
                outputVar := NA_ImageSearch(activated_window,"C:\Users\aflhz\images\검색2.bmp",260,370,830,430,100)
                if(outputVar != 1 and outputVar != -1) {
                    Sleep,1000
                    if(randNum = 1 or randNum = 2) { 
                        NA_MouseClick(activated_window,237,340)
                        Sleep,1000
                    } else if(randNum = 4 or randNum = 3) {
                        NA_MouseClick(activated_window,378,340)
                        Sleep,1000
                    } else if(randNum = 5) {
                        NA_MouseClick(activated_window,521,340)
                        Sleep,1000
                    } else if(randNum = 6 or randNum = 7 or randNum = 8) {
                        NA_MouseClick(activated_window,665,340)
                        Sleep,1000
                    }
                }
			} else {
                hap2 := hap2 + 1
				if(hap2>9) {
					MsgBox,goto_resource 에러 - 자원클릭부분
				} else {
					break
				}
			}
			
		}
		
					
			Sleep,3000
            NA_MouseClick(activated_window,478,303) ;가운데 클릭
            Sleep,3000
            NA_MouseClick(activated_window,718,404) ;채집글씨 클릭
            Sleep,3000
		
        
        ;부대창설 이미지 검색
        outputVar := NA_ImageSearch(activated_window,"C:\Users\aflhz\images\부대창설.bmp",759,131,780,155,90)
        if(outputVar != 1 and outputVar != -1) {
                x := NA_get_Xcoord(outputVar)
                y := NA_get_Ycoord(outputVar)
                NA_MouseClick(activated_window,x+12,y+12)
                Sleep,2500
                
                hap := 1
                loop {
                    outputVar := NA_ImageSearch(activated_window,"C:\Users\aflhz\images\경험치창이떴는지.bmp",100,50,820,90,30)
                    if(outputVar != 1 and outputVar != -1) {
                        Random,randNum,1,2
                        if(randNum == 1) {
                            NA_MouseClick(activated_window,355,415) ;부사령관 빼기
                        }
                    
                     
                        Sleep,2500
                        NA_MouseClick(activated_window,697,509) ;행군 클릭 
                
                        Sleep,2500
                        NA_MouseClick(activated_window,48,530) ;집으로
                        Sleep,2000
                        return
                    } else {
                        hap := hap + 1
                        if (hap > 10) {
                             MsgBox,자원캐러가는거 부대창설 실패 
                            Sleep,10000
                            return
                        } else {
                            Sleep,1000
                        }
                       
                    }
                }
                
                   
                
                
                
        } else {
                NA_MouseClick(activated_window,48,530) ;집으로
                Sleep,1000
                NA_MouseClick(activated_window,48,530) ;집으로
                Sleep,2000
                return
        }
            
        
        
    } else {
        ;에러처리
        MsgBox,자원 보내기 전에 에러 
		handle_error(activated_window)

    }
    return
}

goTo_yaman(activated_window,levelup_num) {
    
	Sleep,1000
    if (check_isInCastle(activated_window) == 1) {
        
        Sleep,1000
        NA_MouseClick(activated_window,48,530) ;성나가기
        Sleep,2500
        NA_MouseClick(activated_window,44,440) ;돋보기 클릭
        Sleep,2000
        
        NA_MouseClick(activated_window,194,511) ;야만인 클릭
        Sleep,1000
        
        loop, 12 {
            NA_MouseClick(activated_window,100,341) ;렙 마이너스
            Sleep,90
        }
        
        
        loop, %levelup_num% {
            NA_MouseClick(activated_window,306,339) ;렙 플러스
            Sleep,100
        }
        
        Sleep,1800
        
        NA_MouseClick(activated_window,208,405) ;검색 클릭
        Sleep,900
        NA_MouseClick(activated_window,478,307) ;야만인 클릭
        Sleep,1500
        
        ;공격클릭
        outputVar := NA_ImageSearch(activated_window,"C:\Users\aflhz\images\공격.bmp",140,140,800,460,80)
            if(outputVar != 1 and outputVar != -1) {
                x := NA_get_Xcoord(outputVar)
                y := NA_get_Ycoord(outputVar)
                NA_MouseClick(activated_window,x+12,y+12)
                Sleep,3300
        }
        
        ;부대창설 이미지 검색 
        outputVar := NA_ImageSearch(activated_window,"C:\Users\aflhz\images\부대창설.bmp",759,131,780,155,80)
        if(outputVar != 1 and outputVar != -1) {
            x := NA_get_Xcoord(outputVar)
            y := NA_get_Ycoord(outputVar)
            NA_MouseClick(activated_window,x+12,y+12)
            Sleep,3300
            
            NA_MouseClick(activated_window,828,237) ;병사 1 클릭
            Sleep,500
            NA_MouseClick(activated_window,828,280) ;병사 2 클릭
            Sleep,500
            NA_MouseClick(activated_window,828,323) ;병사 3 클릭
            Sleep,500

            
            loop {
                NA_MouseClick(activated_window,508,508) ; 병사비우기 한번 눌리고
                Sleep,2000
                outputVar := NA_ImageSearch(activated_window,"C:\Users\aflhz\images\부대창설bar.bmp",503,182,554,200,130)
                if(outputVar != 1 and outputVar != -1) {
                    break
                } else {
                    ;출전할 병사없을때 에러처리 
                }
            }
            
            NA_MouseClick(activated_window,698,508) ; 행군
            Sleep,2000
            NA_MouseClick(activated_window,48,530) ;집으로
            Sleep,1500
            
        } else {
            NA_MouseClick(activated_window,48,530) ;집으로
            Sleep,700
            NA_MouseClick(activated_window,48,530) ;집으로
            Sleep,1500
        }
        
    } else {
        ;에러처리
    }
    
    return
}


mouseScroll(activated_window,start_x,start_y,end_x,end_y) {
    
    lparam := start_x|start_y<<16
    PostMessage,0x201,1,%lparam%,,%activated_window%
    
    loopNum := abs(end_y - start_y)
    increaseNum := 1
    hap := start_y
    
    loop, %loopNum% {
        hap := hap - increaseNum
        lparam := end_x|hap<<16
        PostMessage,0x200,1,%lparam%,,%activated_window%
        if(end_y = hap) {
            break
        }
        Sleep,1
    }
    
    
    
    PostMessage,0x202,0,%lparam%,,%activated_window%
	return
}

get_buff(activated_window) {
	
	Sleep,1000
    if (check_isInCastle(activated_window) == 1) {

        outputVar := NA_ImageSearch(activated_window,"C:\Users\aflhz\images\채집버프체크1.bmp",180,73,330,100,80)
        if(outputVar != 1 and outputVar != -1) {
           Sleep,1300
           return
        } else {
            outputVar := NA_ImageSearch(activated_window,"C:\Users\aflhz\images\채집버프체크2.bmp",180,73,330,100,80)
            if(outputVar != 1 and outputVar != -1) {
                Sleep,1300
                return
            } else {
                ;버프 먹기 부분 넣기 
                outputVar := NA_ImageSearch(activated_window,"C:\Users\aflhz\images\아이템.bmp",674,521,718,557,100)
                if(outputVar != 1 and outputVar != -1) {
                    x := NA_get_Xcoord(outputVar)
                    y := NA_get_Ycoord(outputVar)
                    NA_MouseClick(activated_window,x+12,y+12)
                } else {
                    NA_MouseClick(activated_window,921,542) ;가방아이콘 나오게 펴주고
                    Sleep,1000
                    NA_MouseClick(activated_window,700,540) ; 아이템에 들어가기 
                }
        
                Sleep,2800
        
                NA_MouseClick(activated_window,461,100) ; 버프탭눌리기 
        
                Sleep,2000
        
                ;채집버프 체크 
                outputVar := NA_ImageSearch(activated_window,"C:\Users\aflhz\images\버프채집8시간.bmp",133,146,593,485,100)
                if(outputVar != 1 and outputVar != -1) {
                    x := NA_get_Xcoord(outputVar)
                    y := NA_get_Ycoord(outputVar)
                    NA_MouseClick(activated_window,x+12,y+12)
                    
                    Sleep,2000
        
                    NA_MouseClick(activated_window,737,487) ;사용 클릭 
                } else {
                    outputVar := NA_ImageSearch(activated_window,"C:\Users\aflhz\images\버프채집24시간.bmp",133,146,593,485,100)
                    if(outputVar != 1 and outputVar != -1) {
                        x := NA_get_Xcoord(outputVar)
                        y := NA_get_Ycoord(outputVar)
                        NA_MouseClick(activated_window,x+12,y+12)
                        
                        Sleep,2000
        
                        NA_MouseClick(activated_window,737,487) ;사용 클릭 
                    }
                }
        
                
        
                Sleep,2000
        
                ;이미 버프중이라면 
                outputVar := NA_ImageSearch(activated_window,"C:\Users\aflhz\images\이미버프중.bmp",325,400,389,443,90)
                if(outputVar != 1 and outputVar != -1) {
                NA_MouseClick(activated_window,610,424) ;아니요 클릭
                Sleep,2000
            }
        
        
            ;스크롤
            mouseScroll(activated_window,360,493,360,133)
            Sleep,2000
        
        
        
            ;옥수수 버프 체크 
            outputVar := NA_ImageSearch(activated_window,"C:\Users\aflhz\images\버프옥수수8시간.bmp",133,146,593,540,90)
            if(outputVar != 1 and outputVar != -1) {
                x := NA_get_Xcoord(outputVar)
                y := NA_get_Ycoord(outputVar)
                NA_MouseClick(activated_window,x+12,y+12)
                Sleep,2000
        
                NA_MouseClick(activated_window,737,487) ;사용 클릭 
            } else {
                outputVar := NA_ImageSearch(activated_window,"C:\Users\aflhz\images\버프옥수수24시간.bmp",133,146,593,540,90)
                if(outputVar != 1 and outputVar != -1) {
                    x := NA_get_Xcoord(outputVar)
                    y := NA_get_Ycoord(outputVar)
                    NA_MouseClick(activated_window,x+12,y+12)
                    Sleep,1900
        
                    NA_MouseClick(activated_window,737,487) ;사용 클릭
                }
        }
        
        
        
        Sleep,2000
        
        ;이미 버프중이라면 
        outputVar := NA_ImageSearch(activated_window,"C:\Users\aflhz\images\이미버프중.bmp",325,400,389,443,90)
        if(outputVar != 1 and outputVar != -1) {
            NA_MouseClick(activated_window,610,424) ;아니요 클릭
            Sleep,2000
        }
        ;옥수수 버프 체크 끝
        
        Sleep,2000
        
        ;나무 버프 체크 
        outputVar := NA_ImageSearch(activated_window,"C:\Users\aflhz\images\버프나무8시간.bmp",133,146,593,540,90)
        if(outputVar != 1 and outputVar != -1) {
            x := NA_get_Xcoord(outputVar)
            y := NA_get_Ycoord(outputVar)
            NA_MouseClick(activated_window,x+12,y+12)
            
            Sleep,1900
        
            NA_MouseClick(activated_window,737,487) ;사용 클릭 
            
        } else {
            outputVar := NA_ImageSearch(activated_window,"C:\Users\aflhz\images\버프나무24시간.bmp",133,146,593,540,90)
            if(outputVar != 1 and outputVar != -1) {
                x := NA_get_Xcoord(outputVar)
                y := NA_get_Ycoord(outputVar)
                NA_MouseClick(activated_window,x+12,y+12)
                
                Sleep,1900
        
                NA_MouseClick(activated_window,737,487) ;사용 클릭 
            }
        }
        
        
        
        Sleep,1900
        
        ;이미 버프중이라면 
        outputVar := NA_ImageSearch(activated_window,"C:\Users\aflhz\images\이미버프중.bmp",325,400,389,443,90)
        if(outputVar != 1 and outputVar != -1) {
            NA_MouseClick(activated_window,610,424) ;아니요 클릭
            Sleep,1500
        }
        ;나무 버프 체크 끝
        
        Sleep,2000
        
        ;돌 버프 체크 시작
        outputVar := NA_ImageSearch(activated_window,"C:\Users\aflhz\images\버프돌8시간.bmp",133,146,593,540,90)
        if(outputVar != 1 and outputVar != -1) {
            x := NA_get_Xcoord(outputVar)
            y := NA_get_Ycoord(outputVar)
            NA_MouseClick(activated_window,x+12,y+12)
            
            Sleep,1900
        
            NA_MouseClick(activated_window,737,487) ;사용 클릭 
        } else {
            outputVar := NA_ImageSearch(activated_window,"C:\Users\aflhz\images\버프돌24시간.bmp",133,146,593,540,90)
            if(outputVar != 1 and outputVar != -1) {
                x := NA_get_Xcoord(outputVar)
                y := NA_get_Ycoord(outputVar)
                NA_MouseClick(activated_window,x+12,y+12)
                
                Sleep,1900
        
                NA_MouseClick(activated_window,737,487) ;사용 클릭 
            }
        }
        
        
        Sleep,1500
        
        ;이미 버프중이라면 
        outputVar := NA_ImageSearch(activated_window,"C:\Users\aflhz\images\이미버프중.bmp",325,400,389,443,90)
        if(outputVar != 1 and outputVar != -1) {
            NA_MouseClick(activated_window,610,424) ;아니요 클릭
            Sleep,1900
        }
        ;돌 버프 체크 끝
        
        Sleep,2000
        
        ;금화 버프 체크 시작
        outputVar := NA_ImageSearch(activated_window,"C:\Users\aflhz\images\버프금8시간.bmp",133,146,593,540,90)
        if(outputVar != 1 and outputVar != -1) {
            x := NA_get_Xcoord(outputVar)
            y := NA_get_Ycoord(outputVar)
            NA_MouseClick(activated_window,x+12,y+12)
            
            Sleep,1900
        
            NA_MouseClick(activated_window,737,487) ;사용 클릭 
        } else {
            outputVar := NA_ImageSearch(activated_window,"C:\Users\aflhz\images\버프금24시간.bmp",133,146,593,540,90)
            if(outputVar != 1 and outputVar != -1) {
                x := NA_get_Xcoord(outputVar)
                y := NA_get_Ycoord(outputVar)
                NA_MouseClick(activated_window,x+12,y+12)
                
                Sleep,1900
        
                NA_MouseClick(activated_window,737,487) ;사용 클릭 
            }
        }
        
        
        Sleep,1500
        
        ;이미 버프중이라면 
        outputVar := NA_ImageSearch(activated_window,"C:\Users\aflhz\images\이미버프중.bmp",325,400,389,443,90)
        if(outputVar != 1 and outputVar != -1) {
            NA_MouseClick(activated_window,610,424) ;아니요 클릭
            Sleep,1900
        }
                
                
            }
        }

        
        
        
        
        ;여기까지
        
    } else {
        MsgBox,버프창 열기전에 에러 
        handle_error(activated_window)
        ;에러처리
    }
    
    Sleep,1500
    ;찾닫기 
     NA_MouseClick(activated_window,830,100)
    Sleep,1500
    return
}

create_corps(activated_window) {
	Sleep,1000
    if (check_isInCastle(activated_window) == 1) {
        
        NA_MouseClick(activated_window,48,530) ;성나가기
        Sleep,1900
        NA_MouseClick(activated_window,48,530) ;성나가기
        Sleep,1900
        
        ;1번 생산지 
        NA_MouseClick(activated_window,610,353)
        Sleep,1000
        NA_MouseClick(activated_window,610,353)
        Sleep,1000
        NA_MouseClick(activated_window,710,453)
        Sleep,2500
        
        outputVar := NA_ImageSearch(activated_window,"C:\Users\aflhz\images\이미훈련중.bmp",460,346,500,366,100)
        if(outputVar != 1 and outputVar != -1) {
            NA_MouseClick(activated_window,740,487) ;생산
            Sleep,2500
        } else {
            NA_MouseClick(activated_window,825,100) ;닫기
            Sleep,2500
        }
        
        
        
        ;2번 생산지 
        NA_MouseClick(activated_window,391,376)
        Sleep,1000
        NA_MouseClick(activated_window,391,376)
        Sleep,1000
        NA_MouseClick(activated_window,491,476)
        Sleep,2500
        
        outputVar := NA_ImageSearch(activated_window,"C:\Users\aflhz\images\이미훈련중.bmp",460,346,500,366,80)
        if(outputVar != 1 and outputVar != -1) {
            NA_MouseClick(activated_window,740,487) ;생산
            Sleep,2500
        } else {
            NA_MouseClick(activated_window,825,100) ;닫기
            Sleep,2500
        }
        
        ;3번 생산지 
        NA_MouseClick(activated_window,510,280)
        Sleep,1000
        NA_MouseClick(activated_window,510,280)
        Sleep,1000
        NA_MouseClick(activated_window,610,380)
        Sleep,2500
        
        outputVar := NA_ImageSearch(activated_window,"C:\Users\aflhz\images\이미훈련중.bmp",460,346,500,366,80)
        if(outputVar != 1 and outputVar != -1) {
            NA_MouseClick(activated_window,740,487) ;생산
            Sleep,2500
        } else {
            NA_MouseClick(activated_window,825,100) ;닫기
            Sleep,2500
        }
        
        
        ;4번 생산지 
        NA_MouseClick(activated_window,600,216)
        Sleep,1000
        NA_MouseClick(activated_window,600,216)
        Sleep,1000
        NA_MouseClick(activated_window,700,316) 
        Sleep,2500
        
        outputVar := NA_ImageSearch(activated_window,"C:\Users\aflhz\images\이미훈련중.bmp",460,346,500,366,80)
        if(outputVar != 1 and outputVar != -1) {
            
            NA_MouseClick(activated_window,469,166)
            Sleep,1000
            NA_MouseClick(activated_window,740,487)  ;생산
            Sleep,2500
        } else {
            NA_MouseClick(activated_window,825,100) ;닫기
            Sleep,2500
        }
        
        
    } else {
        ;예외처리
    }
    
    return
}

buy_inStore(activated_window) {
    if (check_isInCastle(activated_window) == 1) {
        
        Sleep,1000
        ;역참클릭
        outputVar := NA_ImageSearch(activated_window,"C:\Users\aflhz\images\역참.bmp",0,0,0,0,130)
        if(outputVar != 1 and outputVar != -1) {
            
            
            x := NA_get_Xcoord(outputVar)
            y := NA_get_Ycoord(outputVar)
            NA_MouseClick(activated_window,x+6,y+6)
            
            
            ;역참창이 제대로 떴는지 확인 
            Sleep,2000
            outputVar := NA_ImageSearch(activated_window,"C:\Users\aflhz\images\경험치창이떴는지.bmp",573,85,733,117,20)
            if(outputVar != 1 and outputVar != -1) {
                
            } else {
                MsgBox, 역참창이 제대로 뜨지 않았습니다
                Sleep,10000
                return
            }
            
                loop {
                    
                
                
                
                    
                Sleep,1500
                
					loop {
						outputVar := NA_ImageSearch(activated_window,"C:\Users\aflhz\images\역참나무.bmp",301,337,765,361,110)
						if(outputVar != 1 and outputVar != -1) {
							x := NA_get_Xcoord(outputVar)
							y := NA_get_Ycoord(outputVar)
							NA_MouseClick(activated_window,x+6,y+6)
							Sleep,1600
						} else {
							outputVar := NA_ImageSearch(activated_window,"C:\Users\aflhz\images\역참옥수수.bmp",300,330,770,370,110)
							if(outputVar != 1 and outputVar != -1) {
								x := NA_get_Xcoord(outputVar)
								y := NA_get_Ycoord(outputVar)
								NA_MouseClick(activated_window,x+6,y+6)
								Sleep,1600
							} else {
								break
							}
						}
					}
                
                    
                    ;스크롤 내리기
                    mouseScroll(activated_window,547,494,547,20)
                    Sleep,1500
                    
                    loop {
                        outputVar := NA_ImageSearch(activated_window,"C:\Users\aflhz\images\역참나무.bmp",300,300,775,324,110)
                        if(outputVar != 1 and outputVar != -1) {
                            x := NA_get_Xcoord(outputVar)
                            y := NA_get_Ycoord(outputVar)
                            NA_MouseClick(activated_window,x+6,y+6)
                            Sleep,1300
                        } else {
                            outputVar := NA_ImageSearch(activated_window,"C:\Users\aflhz\images\역참옥수수.bmp",300,300,775,324,110)
                            if(outputVar != 1 and outputVar != -1) {
                                x := NA_get_Xcoord(outputVar)
                                y := NA_get_Ycoord(outputVar)
                                NA_MouseClick(activated_window,x+6,y+6)
                                Sleep,1300
                            } else {
                                break
                            }
                        }
                    }
                        
                    

                
                outputVar := NA_ImageSearch(activated_window,"C:\Users\aflhz\images\역참보석.bmp",730,160,747,181,110)
                if(outputVar != 1 and outputVar != -1) {
                    ;무료갱신 소모 다하고 보석이 보이면 닫기  
                    Sleep,1500
                    NA_MouseClick(activated_window,817,100)
                    Sleep,2000
                    break
                } else {
                    NA_MouseClick(activated_window,757,156) ;무료 리셋 
                    Sleep,2000
                }
			}   
        }
    } else {
        ;에러처리 
    }
    return
}

get_daliyReward(activated_window) {
    
    
    outputVar := NA_ImageSearch(activated_window,"C:\Users\aflhz\images\일쾌있는지.bmp",50,131,66,149,115)
    if(outputVar != 1 and outputVar != -1) {
        Sleep,2000
        NA_MouseClick(activated_window,32,167) ; 일쾌 입장
        Sleep,2500
        NA_MouseClick(activated_window,72,174) ; 첫번째 보상 페이지 클릭 
        Sleep,1900
        
        
        loop {
            outputVar := NA_ImageSearch(activated_window,"C:\Users\aflhz\images\수령1.bmp",726,320,780,350,110)
            if(outputVar != 1 and outputVar != -1) {
                x := NA_get_Xcoord(outputVar)
                y := NA_get_Ycoord(outputVar)
                NA_MouseClick(activated_window,x+6,y+6)
                Sleep,1700
            } else {
                NA_MouseClick(activated_window,81,277) ; 두번째 보상 페이지 클릭 
                Sleep,1500
                break
            }
        }
        
        
        
        loop {
            outputVar := NA_ImageSearch(activated_window,"C:\Users\aflhz\images\수령2.bmp",729,278,781,307,110)
            if(outputVar != 1 and outputVar != -1) {
                x := NA_get_Xcoord(outputVar)
                y := NA_get_Ycoord(outputVar)
                NA_MouseClick(activated_window,x+6,y+6)
                Sleep,1700
            } else {
                ;보상 싸악 받기 
                Sleep,1000
                NA_MouseClick(activated_window,270,187)
                Sleep,2000
                NA_MouseClick(activated_window,312,107)
                Sleep,2000
                NA_MouseClick(activated_window,401,187)
                Sleep,2000
                NA_MouseClick(activated_window,312,107)
                Sleep,2000
                NA_MouseClick(activated_window,532,187)
                Sleep,2000
                NA_MouseClick(activated_window,312,107)
                Sleep,2000
                NA_MouseClick(activated_window,665,187)
                Sleep,2000
                NA_MouseClick(activated_window,312,107)
                Sleep,2000
                NA_MouseClick(activated_window,795,187)
                Sleep,2000
                NA_MouseClick(activated_window,312,107)
                Sleep,2000
        
                NA_MouseClick(activated_window,820,99) ;닫기
                Sleep,2000
                
                handle_error(activated_window)
                
                break
            }
        }
    }
    
    return
}

open_key(activated_window) {
    Sleep,1000
    if (check_isInCastle(activated_window) == 1) {
        NA_MouseClick(activated_window,236,318) ;건물클릭
        Sleep,1500
        NA_MouseClick(activated_window,336,418) ;주점 입장
        Sleep,4500
        
        ;은열쇠 개봉 
        outputVar := NA_ImageSearch(activated_window,"C:\Users\aflhz\images\오픈.bmp",276,469,333,507,100)
        if(outputVar != 1 and outputVar != -1) {
            x := NA_get_Xcoord(outputVar)
            y := NA_get_Ycoord(outputVar)
            NA_MouseClick(activated_window,x+12,y+12)
            
            Sleep,3500
            
            ;완제나왔으면 확인 눌리기 
             NA_MouseClick(activated_window,111,510)
            Sleep,1000
             NA_MouseClick(activated_window,111,510)
            Sleep,1000
             NA_MouseClick(activated_window,111,510)
            Sleep,1000
            NA_MouseClick(activated_window,111,510)
            Sleep,1000
             NA_MouseClick(activated_window,111,510)
            Sleep,1000
             NA_MouseClick(activated_window,111,510)
            Sleep,1000
            
            
            
        hap := 1
        loop {
            ;보상수령하기 
            Sleep,2000
            outputVar := NA_ImageSearch(activated_window,"C:\Users\aflhz\images\확인_은열쇠.bmp",433,217,512,309,110)
            if(outputVar != 1 and outputVar != -1) {
                x := NA_get_Xcoord(outputVar)
                y := NA_get_Ycoord(outputVar)
                NA_MouseClick(activated_window,233,504)
            } 
            
            Sleep,2000
            
            outputVar := NA_ImageSearch(activated_window,"C:\Users\aflhz\images\주점바탕화면.bmp",238,258,380,380,110)
            if(outputVar != 1 and outputVar != -1) {
                break
            } else {
                NA_MouseClick(activated_window,230,500)
                hap := hap + 1
                
                if(hap = 10) {
                    MsgBox,주점 에러.. 
                    Sleep,10000
                    return
                }
            }
        }
        
        
        Sleep,3000
            
            
        } else {
            ;에러처리
        }
        
        
       
        
        ;금열쇠 개봉 
        outputVar := NA_ImageSearch(activated_window,"C:\Users\aflhz\images\오픈.bmp",656,476,700,500,90)
        if(outputVar != 1 and outputVar != -1) {
            x := NA_get_Xcoord(outputVar)
            y := NA_get_Ycoord(outputVar)
            NA_MouseClick(activated_window,x+12,y+12)
            
            Sleep,4500
        

            ;완제가 나왔는지 check
             NA_MouseClick(activated_window,111,510)
            Sleep,1000
             NA_MouseClick(activated_window,111,510)
            Sleep,1000
             NA_MouseClick(activated_window,111,510)
            Sleep,1000
            NA_MouseClick(activated_window,111,510)
            Sleep,1000
             NA_MouseClick(activated_window,111,510)
            Sleep,1000
             NA_MouseClick(activated_window,111,510)
            Sleep,1000
        
        hap := 1
        loop {
            ;보상수령하기 
            Sleep,2000
            outputVar := NA_ImageSearch(activated_window,"C:\Users\aflhz\images\확인_금열쇠.bmp",433,217,512,309,110)
            if(outputVar != 1 and outputVar != -1) {
                x := NA_get_Xcoord(outputVar)
                y := NA_get_Ycoord(outputVar)
                NA_MouseClick(activated_window,233,504)
            } 
            
            Sleep,2000
            
            outputVar := NA_ImageSearch(activated_window,"C:\Users\aflhz\images\주점바탕화면.bmp",238,258,380,380,110)
            if(outputVar != 1 and outputVar != -1) {
                break
            } else {
                NA_MouseClick(activated_window,230,500)
                hap := hap + 1
                
                if(hap = 10) {
                    MsgBox,주점 에러.. 
                    Sleep,10000
                    return
                }
            }
        }
        

        
        
            Sleep,3000
            } else {
                ;에러처리
            }
        
        
           
        
        NA_MouseClick(activated_window,31,65) ;나가기 
        
        
        Sleep,2000
        
        handle_error(activated_window)
        
    } else {
        ;에러처리
    }
    
    return
}

restart_ROK(activated_window) {
    
    loop {
        NA_MouseClick(activated_window,640,19) ;라오킹 닫고 
        Sleep,3000
        NA_MouseClick(activated_window,314,274) ;다시열어 
    
        Sleep,50000
        
        if (check_isInCastle(activated_window) == 1) {
            return 
        }
        
    }

    
    return 
}

get_unionMoney(activated_window) {
    
    Sleep,1000
    if (check_isInCastle(activated_window) == 1) {
        
		
		;연맹창 들어가서 창이 잘 떳는지까지 확인 
		loop {
			Sleep,1000
			NA_MouseClick(activated_window,921,542) ;가방아이콘 나오게 펴주고
			Sleep,1400
			outputVar := NA_ImageSearch(activated_window,"C:\Users\aflhz\images\아이템.bmp",674,521,718,557,100)
			if(outputVar != 1 and outputVar != -1) {
				NA_MouseClick(activated_window,777,537) ; 연맹에 들어가기
			
				Sleep,3500
			
				;창이 제대로 떴는지 확인 
				outputVar := NA_ImageSearch(activated_window,"C:\Users\aflhz\images\연맹창확인.bmp",732,312,794,378,40)
				if(outputVar != 1 and outputVar != -1) {
					break
				} else {
					MsgBox,연맹창 제대로 또 안뜸
					Sleep,10000
					return
				}
			}
		}
			
		
        
         Sleep,3200
            
		NA_MouseClick(activated_window,666,348) ; 영토들어가기
		Sleep,2500
		NA_MouseClick(activated_window,758,141) ; 수령
		Sleep,2500
		NA_MouseClick(activated_window,840,72) ; 뒤로가기 
		Sleep,2500
        
		NA_MouseClick(activated_window,665,457) ; 선물로 들어가기 
		Sleep,2500
        
		NA_MouseClick(activated_window,700,191) ; 희귀탭 들어가기 
		Sleep,2500
        
		loop {
			outputVar := NA_ImageSearch(activated_window,"C:\Users\aflhz\images\수령.bmp",701,234,751,340,100)
			if(outputVar != 1 and outputVar != -1) {
				x := NA_get_Xcoord(outputVar)
				y := NA_get_Ycoord(outputVar)
				NA_MouseClick(activated_window,x+12,y+12)
				Sleep,2300
			} else {
				break
			}
		}
            
		Sleep,2500
		NA_MouseClick(activated_window,503,193) ; 일반탭으로 
		Sleep,2500
		NA_MouseClick(activated_window,830,194) ; 보상 모두수령하기 클릭  
		Sleep,4000
        
		;확인하여 수령 
		outputVar := NA_ImageSearch(activated_window,"C:\Users\aflhz\images\확인2.bmp",461,416,509,455,100)
		if(outputVar != 1 and outputVar != -1) {
			x := NA_get_Xcoord(outputVar)
			y := NA_get_Ycoord(outputVar)
			NA_MouseClick(activated_window,x+12,y+12)
		}
		
		Sleep,2400
		NA_MouseClick(activated_window,840,72) ; 뒤로가기 
		Sleep,2100
		NA_MouseClick(activated_window,840,72) ; 뒤로가기 
		Sleep,2100
        
    } else {
        MsgBox,연맹창 들어가기 이전에 실패.
        handle_error(activated_window)
        ;에러처리
    }
    
    return
}

get_vipPoint(activated_window) {
    
    Sleep,1000
    if (check_isInCastle(activated_window) == 1) {
        
        NA_MouseClick(activated_window,115,87) ;vip 입장 
        Sleep,3000
        
        outputVar := NA_ImageSearch(activated_window,"C:\Users\aflhz\images\열려있는vip상자.bmp",595,295,635,319,100)
        if(outputVar != 1 and outputVar != -1) {
            
            NA_MouseClick(activated_window,817,100) ;나가기
            Sleep,2000

            
        } else {
			
            Sleep,1000
            NA_MouseClick(activated_window,768,182) ;보상먹기 
            Sleep,3000
            NA_MouseClick(activated_window,376,103) ;더미클릭
            Sleep,1300
            NA_MouseClick(activated_window,376,103) ;더미클릭
            Sleep,700
            NA_MouseClick(activated_window,376,103) ;더미클릭
            Sleep,1600
            NA_MouseClick(activated_window,700,340) ;보상먹기 
            Sleep,3000
            NA_MouseClick(activated_window,700,340) ;보상먹기 
            Sleep,3000
            NA_MouseClick(activated_window,700,340) ;보상먹기 
            Sleep,6000
            NA_MouseClick(activated_window,817,100) ;나가기
            Sleep,4000
            
            
            ;도시락 5개 먹기 
            NA_MouseClick(activated_window,533,56) 
            Sleep,2000
            loop ,5 {
                NA_MouseClick(activated_window,726,177) 
                Sleep,1500
            }
            NA_MouseClick(activated_window,815,100) 
            Sleep,2500
        
        
        
            ;사령관 경험치 올리기 
            outputVar := NA_ImageSearch(activated_window,"C:\Users\aflhz\images\아이템.bmp",674,521,718,557,100)
            if(outputVar != 1 and outputVar != -1) {
                NA_MouseClick(activated_window,841,538)
            } else {
                NA_MouseClick(activated_window,921,542) ;가방아이콘 나오게 펴주고
                Sleep,1500
                NA_MouseClick(activated_window,841,538) ; 연맹에 들어가기 
            }
            
            
        Sleep,4000
        NA_MouseClick(activated_window,152,283) ;첫번째 캐릭 
        Sleep,2500
        
        outputVar := NA_ImageSearch(activated_window,"C:\Users\aflhz\images\경험치플러스.bmp",900,244,925,270,110)
        if(outputVar != 1 and outputVar != -1) {
            x := NA_get_Xcoord(outputVar)
            y := NA_get_Ycoord(outputVar)
            NA_MouseClick(activated_window,x+12,y+12)
        } else {
            Sleep,2500
            NA_MouseClick(activated_window,31,66) ;나가기
            return
        }
        
        Sleep,2000
        
        outputVar := NA_ImageSearch(activated_window,"C:\Users\aflhz\images\경험치창이떴는지.bmp",110,70,190,125,100)
        if(outputVar != 1 and outputVar != -1) {
            loop,5 {
                Sleep,1500
                NA_MouseClick(activated_window,736,227) ;떠있다면 경치책 5번 
            }
            
            Sleep,2000
            NA_MouseClick(activated_window,820,100) ;창닫고
            Sleep,2000
            NA_MouseClick(activated_window,31,66) ;나가기
            Sleep,2000
        } else {
            NA_MouseClick(activated_window,56,389) ;두번쨰
        
            Sleep,2000
            outputVar := NA_ImageSearch(activated_window,"C:\Users\aflhz\images\경험치플러스.bmp",900,244,925,270,110)
            if(outputVar != 1 and outputVar != -1) {
                x := NA_get_Xcoord(outputVar)
                y := NA_get_Ycoord(outputVar)
                NA_MouseClick(activated_window,x+12,y+12)
                
                Sleep,2000
                outputVar := NA_ImageSearch(activated_window,"C:\Users\aflhz\images\경험치창이떴는지.bmp",129,83,181,117,110)
                if(outputVar != 1 and outputVar != -1) {
                    loop,5 {
                        Sleep,1500
                        NA_MouseClick(activated_window,736,227) ;떠있다면 경치책 5번 
                    }
            
                    Sleep,1500
                    NA_MouseClick(activated_window,820,100) ;창닫고
                    Sleep,1500
                    NA_MouseClick(activated_window,31,66) ;나가기
                    Sleep,1000
            
                }
                
            } else {
            Sleep,2500 ;나가기
            return
            }
            
        }
        ;사령관 경치올리기 끝
            
        }
        
        
        Sleep,2000
        
        handle_error(activated_window)
        
            
    } else {
        MsgBox,빕올리기 이전 과정에서 실패.
        handle_error(activated_window)
        ;에러처리
    }
    
    return
}

changing_ID(activated_window) {
    
    Sleep,2500
    NA_MouseClick(activated_window,34,67) ;프로필 클릭 
    Sleep,2500
    NA_MouseClick(activated_window,743,430) ; 설정 클릭
    Sleep,4500
    
		
    ;아이디 바꾸기 
    if(chaing_id_num = 4) {
		
        NA_MouseClick(activated_window,400,317) ; 계정이동 클릭
        Sleep,3000
        NA_MouseClick(activated_window,661,263) ;
        Sleep,3000
        NA_MouseClick(activated_window,601,266) ; 
        Sleep,5000
        
        NA_MouseClick(activated_window,308,372) ; 펭수들 아이디로 이동 
        Sleep,2000

    } else if(chaing_id_num = 6) {
        NA_MouseClick(activated_window,400,317) ; 아이디변경 클릭
        Sleep,3000
        NA_MouseClick(activated_window,661,263) ;
        Sleep,3000
        NA_MouseClick(activated_window,601,266) ; 
        Sleep,5000
        
        NA_MouseClick(activated_window,308,316) ; 다시 aflhzv 아디들로 이동 
        Sleep,2000
    
        chaing_id_num := 0
    } 
    
    if(chaing_id_num = 5) {
        
        NA_MouseClick(activated_window,222,321) ; 아이디 변경 클릭 
    
        Sleep,5500
        ;로그인 1구역 체크 
        outputVar := NA_ImageSearch(activated_window,"C:\Users\aflhz\images\로그인체크.bmp",120,185,157,229,100)
        if(outputVar != 1 and outputVar != -1) {
            NA_MouseClick(activated_window,645,200)
            x := 645
            y := 200
            Sleep,2000
        }
    
        ;로그인 2구역 체크 
        outputVar := NA_ImageSearch(activated_window,"C:\Users\aflhz\images\로그인체크.bmp",441,193,502,224,100)
        if(outputVar != 1 and outputVar != -1) {
            NA_MouseClick(activated_window,285,200)
            x := 285
            y := 200
            Sleep,2000
        }
    }
    
    if(chaing_id_num= 1 or 2 or 3) {
        
		NA_MouseClick(activated_window,222,321) ; 아이디 변경 클릭 
		
		Sleep,5500
		;로그인 1구역 체크 
		outputVar := NA_ImageSearch(activated_window,"C:\Users\aflhz\images\로그인체크.bmp",120,185,157,229,100)
		if(outputVar != 1 and outputVar != -1) {
			NA_MouseClick(activated_window,645,200)
            x := 645
            y := 200
			Sleep,2000
		}
		
		;로그인 2구역 체크 
		outputVar := NA_ImageSearch(activated_window,"C:\Users\aflhz\images\로그인체크.bmp",441,193,502,224,100)
		if(outputVar != 1 and outputVar != -1) {
			NA_MouseClick(activated_window,300,300)
            x := 300
            y := 300
			Sleep,2000
		}
		
		;로그인 3구역 체크 
		outputVar := NA_ImageSearch(activated_window,"C:\Users\aflhz\images\로그인체크.bmp",118,300,159,339,100)
		if(outputVar != 1 and outputVar != -1) {
			NA_MouseClick(activated_window,650,300)
            x := 650
            y := 300
			Sleep,2000
		}
		
		;로그인 4구역 체크 
		outputVar := NA_ImageSearch(activated_window,"C:\Users\aflhz\images\로그인체크.bmp",471,300,515,338,100)
		if(outputVar != 1 and outputVar != -1) {
			NA_MouseClick(activated_window,285,200)
            x := 285
            y := 200
			Sleep,2000
		}
    }
    
	Sleep,1000
    NA_MouseClick(activated_window,613,420)
    
    Sleep,2500
    hap := 1
    loop {
        if(hap = 130) {
            MsgBox,케릭바꾸는거 에러
            Sleep,10000
            break
        }
        if (check_isInCastle(activated_window) == 1) { 
            break
        }
        
        Sleep,1000
        ;캐릭바꿀때 접속 오류 
        outputVar := NA_ImageSearch(activated_window,"C:\Users\aflhz\images\접속확인.bmp",439,403,517,442,100)
        if(outputVar != 1 and outputVar != -1) {
            Sleep,1000
            NA_MouseClick(activated_window,485,422)
            
            outputVar := NA_ImageSearch(activated_window,"C:\Users\aflhz\images\예.bmp",439,403,517,442,100)
            if(outputVar != 1 and outputVar != -1) {
                Sleep,2500
                NA_MouseClick(activated_window,609,423)
                Sleep,2500
            } else {
                Sleep,2500
                NA_MouseClick(activated_window,x,y)
                Sleep,2500
                NA_MouseClick(activated_window,609,423)
                Sleep,2500
            }
        }
        
        hap := hap + 1
    }
    
    Sleep,4500
	chaing_id_num := chaing_id_num + 1
    yaman_num := 1
	
	
    return 
    
}

detect_macroBox(activated_window) {
    
    Sleep,100
	
     loop ,15 {
        Sleep,50
        outputVar := NA_ImageSearch(activated_window,"C:\Users\aflhz\images\매크로탐지그림1.bmp",567,73,863,175,90)
        if(outputVar != 1 and outputVar != -1) {
            x := NA_get_Xcoord(outputVar)
            y := NA_get_Ycoord(outputVar)
            NA_MouseClick(activated_window,x+12,y+12)
            
            Sleep,2000
            outputVar := NA_ImageSearch(activated_window,"C:\Users\aflhz\images\인증.bmp",359,279,805,349,110)
            if(outputVar != 1 and outputVar != -1) {
                x := NA_get_Xcoord(outputVar)
                y := NA_get_Ycoord(outputVar)
                NA_MouseClick(activated_window,x+12,y+12)
            }
            
            Sleep,4000
            
            WinActivate,%activated_window%
            
            Sleep,7000
            
            ; 풀때까지 대기 
            loop {
                
            outputVar := NA_ImageSearch(activated_window,"C:\Users\aflhz\images\매크로확인.bmp",538,452,595,487,95)
            if(outputVar != 1 and outputVar != -1) {
                ;아직안풀림
            } else {
                    break
                }
                Sleep,1000
            }
            
            
            
        }
        
        Sleep, 50
		
        outputVar := NA_ImageSearch(activated_window,"C:\Users\aflhz\images\매크로탐지그림1.bmp",567,73,863,175,90)
        if(outputVar != 1 and outputVar != -1) {
            x := NA_get_Xcoord(outputVar)
            y := NA_get_Ycoord(outputVar)
            NA_MouseClick(activated_window,x+12,y+12)
            
            Sleep,2000
            outputVar := NA_ImageSearch(activated_window,"C:\Users\aflhz\images\인증.bmp",359,279,805,349,110)
            if(outputVar != 1 and outputVar != -1) {
                x := NA_get_Xcoord(outputVar)
                y := NA_get_Ycoord(outputVar)
                NA_MouseClick(activated_window,x+12,y+12)
            }
            
            Sleep,4000
            
            WinActivate,%activated_window%
            
            Sleep,7000
            
            ; 풀때까지 대기 
            loop {
                
            outputVar := NA_ImageSearch(activated_window,"C:\Users\aflhz\images\매크로확인.bmp",538,452,595,487,95)
            if(outputVar != 1 and outputVar != -1) {
                ;아직안풀림
            } else {
                    break
                }
                Sleep,1000
            }
            
            
            
			}
	}
	return

}


do_oneCycle(activated_window) {
        
		
        Sleep,700
        detect_macroBox(activated_window)
		
        loop {
            hap := check_isInCastle(activated_window)
            Sleep,1000
			if (hap = 1) {
				break
			} else if(hap = -1){
                MsgBox, %activated_window% : 접속화면이 아닙니다. hap = %hap%
                Sleep,11000
            }
		}
		
		Sleep,1500
        
		help_union(activated_window)
		
		if(is_full_corps_outCastle(activated_window) == 1) {
			
				Sleep,1000
                
                main_cycle_num := main_cycle_num + 1
            } else {
                
                Sleep,2000
            
                if(yaman_num < 6) {
                    
                    goTo_yaman(activated_window,8)
                    Sleep,13000
                    yaman_num := yaman_num + 1
                } else {
                    
                    Sleep,2500
					
                    Random,rand,3,6
                    
                    goTo_resource(activated_window,rand)
                    Sleep,13000
                }
                

                main_cycle_num := main_cycle_num + 1
            }
            
            hap := Mod(main_cycle_num,MAIN_CYCLE_MAX_NUM)
            
            if(hap = 0) {
                
                Sleep,1500
                get_resource_inCastle(activated_window)
                Sleep,2500
                create_corps(activated_window)
                
                
                Sleep,2500
                get_buff(activated_window)
                Sleep,2500
                buy_inStore(activated_window)
                Sleep,2500
                open_key(activated_window)
                Sleep,2500
                get_unionMoney(activated_window)
                Sleep,2500
                get_vipPoint(activated_window)
                Sleep,2500
                get_daliyReward(activated_window)
                Sleep,2500
                
                detect_macroBox(activated_window)
                
                Sleep,2500
                
                changing_ID(activated_window) 
                return
				}
	return
}



handle_error(activated_window) {
    
    if (check_isInCastle(activated_window) == 0) {
        
        loop {
            Sleep,1000
            if (check_isInCastle(activated_window) == 1) {
                break
            }
        }
    }
    return
}

;~ F1::


loop {
    Sleep,100
    do_oneCycle(activated_window)
}


 


;~ F2:: Reload