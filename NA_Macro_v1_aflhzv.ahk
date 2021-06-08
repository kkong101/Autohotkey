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
            outputVar := NA_ImageSearch(activated_window,"C:\Users\aflhz\images\���������Ǽ�.bmp",140,140,850,490,90)
            if(outputVar != 1 and outputVar != -1) {
            x := NA_get_Xcoord(outputVar)
            y := NA_get_Ycoord(outputVar)
            NA_MouseClick(activated_window,x+20,y+20)
            Sleep,1000
            outputVar := NA_ImageSearch(activated_window,"C:\Users\aflhz\images\���������Ǽ�.bmp",140,140,850,490,90)
            if(outputVar != 1 and outputVar != -1) {
                NA_MouseClick(activated_window,x+3,y+3)
            }
        }
    } else {
        
        return 
    }
    
    return
}


;~ ;���ȿ� ������ 1 ��ȯ, �ۿ������� ������ ������ 1 ȯȯ, �ƿ� ��ã���� -1 ��ȯ
check_isInCastle(activated_window) {
    
     outputVar := NA_ImageSearch(activated_window,"C:\Users\aflhz\images\���ȿ�����2.bmp",5,480,90,570,125)
    if(outputVar != 1 and outputVar != -1) {
        return true
    }
    
    outputVar := NA_ImageSearch(activated_window,"C:\Users\aflhz\images\���ȿ�����3.bmp",5,480,90,570,125)
    if(outputVar != 1 and outputVar != -1) {
        return true
    }
    
    outputVar := NA_ImageSearch(activated_window,"C:\Users\aflhz\images\���ȿ�����5.bmp",5,480,90,570,130)
    if(outputVar != 1 and outputVar != -1) {
        return true
    } else {
        outputVar := NA_ImageSearch(activated_window,"C:\Users\aflhz\images\����ȭ��6.bmp",10,474,90,575,125)
        if(outputVar != 1 and outputVar != -1) {
            x := NA_get_Xcoord(outputVar)
            y := NA_get_Ycoord(outputVar)
            NA_MouseClick(activated_window,x+10,y+10)
            Sleep,1500
            return true
        }
    }
    
    outputVar := NA_ImageSearch(activated_window,"C:\Users\aflhz\images\����ȭ��.bmp",5,480,90,570,125)
    if(outputVar != 1 and outputVar != -1) {
        return true
    } else {
        outputVar := NA_ImageSearch(activated_window,"C:\Users\aflhz\images\����ȭ��2.bmp",10,474,90,575,125)
            if(outputVar != 1 and outputVar != -1) {
                x := NA_get_Xcoord(outputVar)
                y := NA_get_Ycoord(outputVar)
                NA_MouseClick(activated_window,x+10,y+10)
                Sleep,1500
                return true
            }
    }
    
    
    outputVar := NA_ImageSearch(activated_window,"C:\Users\aflhz\images\����ȭ��3.bmp",5,480,90,570,125)
    if(outputVar != 1 and outputVar != -1) {
        return true
    } else {
        outputVar := NA_ImageSearch(activated_window,"C:\Users\aflhz\images\����ȭ��4.bmp",10,474,90,575,125)
            if(outputVar != 1 and outputVar != -1) {
                x := NA_get_Xcoord(outputVar)
                y := NA_get_Ycoord(outputVar)
                NA_MouseClick(activated_window,x+10,y+10)
                Sleep,1500
                return true
            }
    }
    
    
    outputVar := NA_ImageSearch(activated_window,"C:\Users\aflhz\images\���ȿ�����.bmp",10,484,80,566,125)
    if(outputVar != 1 and outputVar != -1) {
        return true
    } else {
        outputVar := NA_ImageSearch(activated_window,"C:\Users\aflhz\images\���ۿ�����.bmp",10,474,90,575,125)
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
        
            outputVar := NA_ImageSearch(activated_window,"C:\Users\aflhz\images\���ÿ�����.bmp",140,140,850,490,100)
            if(outputVar != 1 and outputVar != -1) {
                x := NA_get_Xcoord(outputVar)
                y := NA_get_Ycoord(outputVar)
                NA_MouseClick(activated_window,x+18,y+18)
                Sleep,1700
            }
            
            outputVar := NA_ImageSearch(activated_window,"C:\Users\aflhz\images\���ó���.bmp",140,140,850,490,90)
            if(outputVar != 1 and outputVar != -1) {
                x := NA_get_Xcoord(outputVar)
                y := NA_get_Ycoord(outputVar)
                NA_MouseClick(activated_window,x+20,y+20)
                Sleep,1700
            }
            
            outputVar := NA_ImageSearch(activated_window,"C:\Users\aflhz\images\���õ�.bmp",140,140,850,490,90)
            if(outputVar != 1 and outputVar != -1) {
                x := NA_get_Xcoord(outputVar)
                y := NA_get_Ycoord(outputVar)
                NA_MouseClick(activated_window,x+8,y+8)
				outputVar := NA_ImageSearch(activated_window,"C:\Users\aflhz\images\���õ�.bmp",140,140,850,490,90)
            if(outputVar != 1 and outputVar != -1) {
				x := NA_get_Xcoord(outputVar)
                y := NA_get_Ycoord(outputVar)
                NA_MouseClick(activated_window,x+20,y+20)
			}
				
                Sleep,1700
            }
            
            outputVar := NA_ImageSearch(activated_window,"C:\Users\aflhz\images\���ñ�.bmp",140,140,850,490,90)
            if(outputVar != 1 and outputVar != -1) {
                x := NA_get_Xcoord(outputVar)
                y := NA_get_Ycoord(outputVar)
                NA_MouseClick(activated_window,x+18,y+18)
                Sleep,1700
            }
        } else {
            ;����ó��
        }
    return
}


; true �� Ǯ���� false �� �������� ���� 
is_full_corps_outCastle(activated_window) {
    
    ;�� ����� ���� �� ���� ã�� �״��� �����ִ� ���� Ž�� 
    if (check_isInCastle(activated_window) == 1) {
        outputVar := NA_ImageSearch(activated_window,"C:\Users\aflhz\images\�δ�üũ����5.bmp",923,160,945,177,110)
            if(outputVar != 1 and outputVar != -1) {
                if (check_isInCastle(activated_window) == 1) {
                    outputVar := NA_ImageSearch(activated_window,"C:\Users\aflhz\images\�δ�üũ����5.bmp",910,160,922,177,110)
                    if(outputVar != 1 and outputVar != -1) {
                        return true 
                    } else {
                        return false 
                    } 
                }
            } else {
                outputVar := NA_ImageSearch(activated_window,"C:\Users\aflhz\images\�δ�üũ����4.bmp",923,160,945,177,110)
                if(outputVar != 1 and outputVar != -1) {
                    if (check_isInCastle(activated_window) == 1) {
                        outputVar := NA_ImageSearch(activated_window,"C:\Users\aflhz\images\�δ�üũ����4.bmp",910,160,922,177,110)
                        if(outputVar != 1 and outputVar != -1) {
                            return true 
                        } else {
                            return false
                        } 
                    }
                } else {
                    ;���� �ִ� 3�� Ž�� 
                    outputVar := NA_ImageSearch(activated_window,"C:\Users\aflhz\images\�δ�üũ����3.bmp",923,160,945,177,110)
                    if(outputVar != 1 and outputVar != -1) {
                        if (check_isInCastle(activated_window) == 1) {
                            outputVar := NA_ImageSearch(activated_window,"C:\Users\aflhz\images\�δ�üũ����3.bmp",910,160,922,177,110)
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
        
            
		;������ �ڿ��� ��ĺ���� Ž�� 
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
        NA_MouseClick(activated_window,48,530) ;��������
        Sleep,2000
        NA_MouseClick(activated_window,44,440) ;������ Ŭ��
        Sleep,2000
        
        
        
        if(randNum = 1 or randNum = 2) {
            ;�ķ� 
            NA_MouseClick(activated_window,336,516) ;�ķ�Ŭ��
            Sleep,1500
            
            ;�����ʱ�ȭ
            loop, 6 {
                NA_MouseClick(activated_window,237,340)
                Sleep,100
            }
			
			Sleep,1000
            
            ;������
            loop, %levelup_num% {
                NA_MouseClick(activated_window,441,339)
                Sleep,100
            }
            
            
            
        } else if (randNum = 4 or randNum = 3) {
            ;����

            NA_MouseClick(activated_window,485,516) ;����Ŭ��
            Sleep,1500
            
            ;�����ʱ�ȭ
            loop, 6 {
                NA_MouseClick(activated_window,378,340)
                Sleep,100
            }
			
			Sleep,1000
            
            ;������
            loop, %levelup_num% {
                NA_MouseClick(activated_window,582,339)
                Sleep,100
            }
            
        
        } else if (randNum = 5) {
            ;��

            NA_MouseClick(activated_window,622,516) ;��Ŭ��
            Sleep,1500
            
            ;�����ʱ�ȭ
            loop, 6 {
                NA_MouseClick(activated_window,521,340)
                Sleep,70
            }
			
			Sleep,1000
            
            ;������
            loop, %levelup_num% {
                NA_MouseClick(activated_window,726,339)
                Sleep,70
            }
            
            
        } else if (randNum = 6 or randNum = 7 or randNum = 8) {
            ;��

            NA_MouseClick(activated_window,761,516) ;��Ŭ��
            Sleep,1500
            
            ;�����ʱ�ȭ
            loop, 6 {
                NA_MouseClick(activated_window,665,340)
                Sleep,70
            }
			
			Sleep,1000
            
            ;������
            loop, %levelup_num% {
                NA_MouseClick(activated_window,871,339)
                Sleep,70
            }
        }
		
		Sleep,2500
		
		hap2 := 1
		;�˻� ã�Ƽ� Ŭ�� 
		loop {
			Sleep,1000
			
			outputVar := NA_ImageSearch(activated_window,"C:\Users\aflhz\images\�˻�2.bmp",260,370,830,430,100)
			if(outputVar != 1 and outputVar != -1) {
				x := NA_get_Xcoord(outputVar)
				y := NA_get_Ycoord(outputVar)
				NA_MouseClick(activated_window,x+15,y+15)
                
                outputVar := NA_ImageSearch(activated_window,"C:\Users\aflhz\images\�˻�2.bmp",260,370,830,430,100)
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
					MsgBox,goto_resource ���� - �ڿ�Ŭ���κ�
				} else {
					break
				}
			}
			
		}
		
					
			Sleep,3000
            NA_MouseClick(activated_window,478,303) ;��� Ŭ��
            Sleep,3000
            NA_MouseClick(activated_window,718,404) ;ä���۾� Ŭ��
            Sleep,3000
		
        
        ;�δ�â�� �̹��� �˻�
        outputVar := NA_ImageSearch(activated_window,"C:\Users\aflhz\images\�δ�â��.bmp",759,131,780,155,90)
        if(outputVar != 1 and outputVar != -1) {
                x := NA_get_Xcoord(outputVar)
                y := NA_get_Ycoord(outputVar)
                NA_MouseClick(activated_window,x+12,y+12)
                Sleep,2500
                
                hap := 1
                loop {
                    outputVar := NA_ImageSearch(activated_window,"C:\Users\aflhz\images\����ġâ�̶�����.bmp",100,50,820,90,30)
                    if(outputVar != 1 and outputVar != -1) {
                        Random,randNum,1,2
                        if(randNum == 1) {
                            NA_MouseClick(activated_window,355,415) ;�λ�ɰ� ����
                        }
                    
                     
                        Sleep,2500
                        NA_MouseClick(activated_window,697,509) ;�౺ Ŭ�� 
                
                        Sleep,2500
                        NA_MouseClick(activated_window,48,530) ;������
                        Sleep,2000
                        return
                    } else {
                        hap := hap + 1
                        if (hap > 10) {
                             MsgBox,�ڿ�ĳ�����°� �δ�â�� ���� 
                            Sleep,10000
                            return
                        } else {
                            Sleep,1000
                        }
                       
                    }
                }
                
                   
                
                
                
        } else {
                NA_MouseClick(activated_window,48,530) ;������
                Sleep,1000
                NA_MouseClick(activated_window,48,530) ;������
                Sleep,2000
                return
        }
            
        
        
    } else {
        ;����ó��
        MsgBox,�ڿ� ������ ���� ���� 
		handle_error(activated_window)

    }
    return
}

goTo_yaman(activated_window,levelup_num) {
    
	Sleep,1000
    if (check_isInCastle(activated_window) == 1) {
        
        Sleep,1000
        NA_MouseClick(activated_window,48,530) ;��������
        Sleep,2500
        NA_MouseClick(activated_window,44,440) ;������ Ŭ��
        Sleep,2000
        
        NA_MouseClick(activated_window,194,511) ;�߸��� Ŭ��
        Sleep,1000
        
        loop, 12 {
            NA_MouseClick(activated_window,100,341) ;�� ���̳ʽ�
            Sleep,90
        }
        
        
        loop, %levelup_num% {
            NA_MouseClick(activated_window,306,339) ;�� �÷���
            Sleep,100
        }
        
        Sleep,1800
        
        NA_MouseClick(activated_window,208,405) ;�˻� Ŭ��
        Sleep,900
        NA_MouseClick(activated_window,478,307) ;�߸��� Ŭ��
        Sleep,1500
        
        ;����Ŭ��
        outputVar := NA_ImageSearch(activated_window,"C:\Users\aflhz\images\����.bmp",140,140,800,460,80)
            if(outputVar != 1 and outputVar != -1) {
                x := NA_get_Xcoord(outputVar)
                y := NA_get_Ycoord(outputVar)
                NA_MouseClick(activated_window,x+12,y+12)
                Sleep,3300
        }
        
        ;�δ�â�� �̹��� �˻� 
        outputVar := NA_ImageSearch(activated_window,"C:\Users\aflhz\images\�δ�â��.bmp",759,131,780,155,80)
        if(outputVar != 1 and outputVar != -1) {
            x := NA_get_Xcoord(outputVar)
            y := NA_get_Ycoord(outputVar)
            NA_MouseClick(activated_window,x+12,y+12)
            Sleep,3300
            
            NA_MouseClick(activated_window,828,237) ;���� 1 Ŭ��
            Sleep,500
            NA_MouseClick(activated_window,828,280) ;���� 2 Ŭ��
            Sleep,500
            NA_MouseClick(activated_window,828,323) ;���� 3 Ŭ��
            Sleep,500

            
            loop {
                NA_MouseClick(activated_window,508,508) ; ������� �ѹ� ������
                Sleep,2000
                outputVar := NA_ImageSearch(activated_window,"C:\Users\aflhz\images\�δ�â��bar.bmp",503,182,554,200,130)
                if(outputVar != 1 and outputVar != -1) {
                    break
                } else {
                    ;������ ��������� ����ó�� 
                }
            }
            
            NA_MouseClick(activated_window,698,508) ; �౺
            Sleep,2000
            NA_MouseClick(activated_window,48,530) ;������
            Sleep,1500
            
        } else {
            NA_MouseClick(activated_window,48,530) ;������
            Sleep,700
            NA_MouseClick(activated_window,48,530) ;������
            Sleep,1500
        }
        
    } else {
        ;����ó��
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

        outputVar := NA_ImageSearch(activated_window,"C:\Users\aflhz\images\ä������üũ1.bmp",180,73,330,100,80)
        if(outputVar != 1 and outputVar != -1) {
           Sleep,1300
           return
        } else {
            outputVar := NA_ImageSearch(activated_window,"C:\Users\aflhz\images\ä������üũ2.bmp",180,73,330,100,80)
            if(outputVar != 1 and outputVar != -1) {
                Sleep,1300
                return
            } else {
                ;���� �Ա� �κ� �ֱ� 
                outputVar := NA_ImageSearch(activated_window,"C:\Users\aflhz\images\������.bmp",674,521,718,557,100)
                if(outputVar != 1 and outputVar != -1) {
                    x := NA_get_Xcoord(outputVar)
                    y := NA_get_Ycoord(outputVar)
                    NA_MouseClick(activated_window,x+12,y+12)
                } else {
                    NA_MouseClick(activated_window,921,542) ;��������� ������ ���ְ�
                    Sleep,1000
                    NA_MouseClick(activated_window,700,540) ; �����ۿ� ���� 
                }
        
                Sleep,2800
        
                NA_MouseClick(activated_window,461,100) ; �����Ǵ����� 
        
                Sleep,2000
        
                ;ä������ üũ 
                outputVar := NA_ImageSearch(activated_window,"C:\Users\aflhz\images\����ä��8�ð�.bmp",133,146,593,485,100)
                if(outputVar != 1 and outputVar != -1) {
                    x := NA_get_Xcoord(outputVar)
                    y := NA_get_Ycoord(outputVar)
                    NA_MouseClick(activated_window,x+12,y+12)
                    
                    Sleep,2000
        
                    NA_MouseClick(activated_window,737,487) ;��� Ŭ�� 
                } else {
                    outputVar := NA_ImageSearch(activated_window,"C:\Users\aflhz\images\����ä��24�ð�.bmp",133,146,593,485,100)
                    if(outputVar != 1 and outputVar != -1) {
                        x := NA_get_Xcoord(outputVar)
                        y := NA_get_Ycoord(outputVar)
                        NA_MouseClick(activated_window,x+12,y+12)
                        
                        Sleep,2000
        
                        NA_MouseClick(activated_window,737,487) ;��� Ŭ�� 
                    }
                }
        
                
        
                Sleep,2000
        
                ;�̹� �������̶�� 
                outputVar := NA_ImageSearch(activated_window,"C:\Users\aflhz\images\�̹̹�����.bmp",325,400,389,443,90)
                if(outputVar != 1 and outputVar != -1) {
                NA_MouseClick(activated_window,610,424) ;�ƴϿ� Ŭ��
                Sleep,2000
            }
        
        
            ;��ũ��
            mouseScroll(activated_window,360,493,360,133)
            Sleep,2000
        
        
        
            ;������ ���� üũ 
            outputVar := NA_ImageSearch(activated_window,"C:\Users\aflhz\images\����������8�ð�.bmp",133,146,593,540,90)
            if(outputVar != 1 and outputVar != -1) {
                x := NA_get_Xcoord(outputVar)
                y := NA_get_Ycoord(outputVar)
                NA_MouseClick(activated_window,x+12,y+12)
                Sleep,2000
        
                NA_MouseClick(activated_window,737,487) ;��� Ŭ�� 
            } else {
                outputVar := NA_ImageSearch(activated_window,"C:\Users\aflhz\images\����������24�ð�.bmp",133,146,593,540,90)
                if(outputVar != 1 and outputVar != -1) {
                    x := NA_get_Xcoord(outputVar)
                    y := NA_get_Ycoord(outputVar)
                    NA_MouseClick(activated_window,x+12,y+12)
                    Sleep,1900
        
                    NA_MouseClick(activated_window,737,487) ;��� Ŭ��
                }
        }
        
        
        
        Sleep,2000
        
        ;�̹� �������̶�� 
        outputVar := NA_ImageSearch(activated_window,"C:\Users\aflhz\images\�̹̹�����.bmp",325,400,389,443,90)
        if(outputVar != 1 and outputVar != -1) {
            NA_MouseClick(activated_window,610,424) ;�ƴϿ� Ŭ��
            Sleep,2000
        }
        ;������ ���� üũ ��
        
        Sleep,2000
        
        ;���� ���� üũ 
        outputVar := NA_ImageSearch(activated_window,"C:\Users\aflhz\images\��������8�ð�.bmp",133,146,593,540,90)
        if(outputVar != 1 and outputVar != -1) {
            x := NA_get_Xcoord(outputVar)
            y := NA_get_Ycoord(outputVar)
            NA_MouseClick(activated_window,x+12,y+12)
            
            Sleep,1900
        
            NA_MouseClick(activated_window,737,487) ;��� Ŭ�� 
            
        } else {
            outputVar := NA_ImageSearch(activated_window,"C:\Users\aflhz\images\��������24�ð�.bmp",133,146,593,540,90)
            if(outputVar != 1 and outputVar != -1) {
                x := NA_get_Xcoord(outputVar)
                y := NA_get_Ycoord(outputVar)
                NA_MouseClick(activated_window,x+12,y+12)
                
                Sleep,1900
        
                NA_MouseClick(activated_window,737,487) ;��� Ŭ�� 
            }
        }
        
        
        
        Sleep,1900
        
        ;�̹� �������̶�� 
        outputVar := NA_ImageSearch(activated_window,"C:\Users\aflhz\images\�̹̹�����.bmp",325,400,389,443,90)
        if(outputVar != 1 and outputVar != -1) {
            NA_MouseClick(activated_window,610,424) ;�ƴϿ� Ŭ��
            Sleep,1500
        }
        ;���� ���� üũ ��
        
        Sleep,2000
        
        ;�� ���� üũ ����
        outputVar := NA_ImageSearch(activated_window,"C:\Users\aflhz\images\������8�ð�.bmp",133,146,593,540,90)
        if(outputVar != 1 and outputVar != -1) {
            x := NA_get_Xcoord(outputVar)
            y := NA_get_Ycoord(outputVar)
            NA_MouseClick(activated_window,x+12,y+12)
            
            Sleep,1900
        
            NA_MouseClick(activated_window,737,487) ;��� Ŭ�� 
        } else {
            outputVar := NA_ImageSearch(activated_window,"C:\Users\aflhz\images\������24�ð�.bmp",133,146,593,540,90)
            if(outputVar != 1 and outputVar != -1) {
                x := NA_get_Xcoord(outputVar)
                y := NA_get_Ycoord(outputVar)
                NA_MouseClick(activated_window,x+12,y+12)
                
                Sleep,1900
        
                NA_MouseClick(activated_window,737,487) ;��� Ŭ�� 
            }
        }
        
        
        Sleep,1500
        
        ;�̹� �������̶�� 
        outputVar := NA_ImageSearch(activated_window,"C:\Users\aflhz\images\�̹̹�����.bmp",325,400,389,443,90)
        if(outputVar != 1 and outputVar != -1) {
            NA_MouseClick(activated_window,610,424) ;�ƴϿ� Ŭ��
            Sleep,1900
        }
        ;�� ���� üũ ��
        
        Sleep,2000
        
        ;��ȭ ���� üũ ����
        outputVar := NA_ImageSearch(activated_window,"C:\Users\aflhz\images\������8�ð�.bmp",133,146,593,540,90)
        if(outputVar != 1 and outputVar != -1) {
            x := NA_get_Xcoord(outputVar)
            y := NA_get_Ycoord(outputVar)
            NA_MouseClick(activated_window,x+12,y+12)
            
            Sleep,1900
        
            NA_MouseClick(activated_window,737,487) ;��� Ŭ�� 
        } else {
            outputVar := NA_ImageSearch(activated_window,"C:\Users\aflhz\images\������24�ð�.bmp",133,146,593,540,90)
            if(outputVar != 1 and outputVar != -1) {
                x := NA_get_Xcoord(outputVar)
                y := NA_get_Ycoord(outputVar)
                NA_MouseClick(activated_window,x+12,y+12)
                
                Sleep,1900
        
                NA_MouseClick(activated_window,737,487) ;��� Ŭ�� 
            }
        }
        
        
        Sleep,1500
        
        ;�̹� �������̶�� 
        outputVar := NA_ImageSearch(activated_window,"C:\Users\aflhz\images\�̹̹�����.bmp",325,400,389,443,90)
        if(outputVar != 1 and outputVar != -1) {
            NA_MouseClick(activated_window,610,424) ;�ƴϿ� Ŭ��
            Sleep,1900
        }
                
                
            }
        }

        
        
        
        
        ;�������
        
    } else {
        MsgBox,����â �������� ���� 
        handle_error(activated_window)
        ;����ó��
    }
    
    Sleep,1500
    ;ã�ݱ� 
     NA_MouseClick(activated_window,830,100)
    Sleep,1500
    return
}

create_corps(activated_window) {
	Sleep,1000
    if (check_isInCastle(activated_window) == 1) {
        
        NA_MouseClick(activated_window,48,530) ;��������
        Sleep,1900
        NA_MouseClick(activated_window,48,530) ;��������
        Sleep,1900
        
        ;1�� ������ 
        NA_MouseClick(activated_window,610,353)
        Sleep,1000
        NA_MouseClick(activated_window,610,353)
        Sleep,1000
        NA_MouseClick(activated_window,710,453)
        Sleep,2500
        
        outputVar := NA_ImageSearch(activated_window,"C:\Users\aflhz\images\�̹��Ʒ���.bmp",460,346,500,366,100)
        if(outputVar != 1 and outputVar != -1) {
            NA_MouseClick(activated_window,740,487) ;����
            Sleep,2500
        } else {
            NA_MouseClick(activated_window,825,100) ;�ݱ�
            Sleep,2500
        }
        
        
        
        ;2�� ������ 
        NA_MouseClick(activated_window,391,376)
        Sleep,1000
        NA_MouseClick(activated_window,391,376)
        Sleep,1000
        NA_MouseClick(activated_window,491,476)
        Sleep,2500
        
        outputVar := NA_ImageSearch(activated_window,"C:\Users\aflhz\images\�̹��Ʒ���.bmp",460,346,500,366,80)
        if(outputVar != 1 and outputVar != -1) {
            NA_MouseClick(activated_window,740,487) ;����
            Sleep,2500
        } else {
            NA_MouseClick(activated_window,825,100) ;�ݱ�
            Sleep,2500
        }
        
        ;3�� ������ 
        NA_MouseClick(activated_window,510,280)
        Sleep,1000
        NA_MouseClick(activated_window,510,280)
        Sleep,1000
        NA_MouseClick(activated_window,610,380)
        Sleep,2500
        
        outputVar := NA_ImageSearch(activated_window,"C:\Users\aflhz\images\�̹��Ʒ���.bmp",460,346,500,366,80)
        if(outputVar != 1 and outputVar != -1) {
            NA_MouseClick(activated_window,740,487) ;����
            Sleep,2500
        } else {
            NA_MouseClick(activated_window,825,100) ;�ݱ�
            Sleep,2500
        }
        
        
        ;4�� ������ 
        NA_MouseClick(activated_window,600,216)
        Sleep,1000
        NA_MouseClick(activated_window,600,216)
        Sleep,1000
        NA_MouseClick(activated_window,700,316) 
        Sleep,2500
        
        outputVar := NA_ImageSearch(activated_window,"C:\Users\aflhz\images\�̹��Ʒ���.bmp",460,346,500,366,80)
        if(outputVar != 1 and outputVar != -1) {
            
            NA_MouseClick(activated_window,469,166)
            Sleep,1000
            NA_MouseClick(activated_window,740,487)  ;����
            Sleep,2500
        } else {
            NA_MouseClick(activated_window,825,100) ;�ݱ�
            Sleep,2500
        }
        
        
    } else {
        ;����ó��
    }
    
    return
}

buy_inStore(activated_window) {
    if (check_isInCastle(activated_window) == 1) {
        
        Sleep,1000
        ;����Ŭ��
        outputVar := NA_ImageSearch(activated_window,"C:\Users\aflhz\images\����.bmp",0,0,0,0,130)
        if(outputVar != 1 and outputVar != -1) {
            
            
            x := NA_get_Xcoord(outputVar)
            y := NA_get_Ycoord(outputVar)
            NA_MouseClick(activated_window,x+6,y+6)
            
            
            ;����â�� ����� ������ Ȯ�� 
            Sleep,2000
            outputVar := NA_ImageSearch(activated_window,"C:\Users\aflhz\images\����ġâ�̶�����.bmp",573,85,733,117,20)
            if(outputVar != 1 and outputVar != -1) {
                
            } else {
                MsgBox, ����â�� ����� ���� �ʾҽ��ϴ�
                Sleep,10000
                return
            }
            
                loop {
                    
                
                
                
                    
                Sleep,1500
                
					loop {
						outputVar := NA_ImageSearch(activated_window,"C:\Users\aflhz\images\��������.bmp",301,337,765,361,110)
						if(outputVar != 1 and outputVar != -1) {
							x := NA_get_Xcoord(outputVar)
							y := NA_get_Ycoord(outputVar)
							NA_MouseClick(activated_window,x+6,y+6)
							Sleep,1600
						} else {
							outputVar := NA_ImageSearch(activated_window,"C:\Users\aflhz\images\����������.bmp",300,330,770,370,110)
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
                
                    
                    ;��ũ�� ������
                    mouseScroll(activated_window,547,494,547,20)
                    Sleep,1500
                    
                    loop {
                        outputVar := NA_ImageSearch(activated_window,"C:\Users\aflhz\images\��������.bmp",300,300,775,324,110)
                        if(outputVar != 1 and outputVar != -1) {
                            x := NA_get_Xcoord(outputVar)
                            y := NA_get_Ycoord(outputVar)
                            NA_MouseClick(activated_window,x+6,y+6)
                            Sleep,1300
                        } else {
                            outputVar := NA_ImageSearch(activated_window,"C:\Users\aflhz\images\����������.bmp",300,300,775,324,110)
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
                        
                    

                
                outputVar := NA_ImageSearch(activated_window,"C:\Users\aflhz\images\��������.bmp",730,160,747,181,110)
                if(outputVar != 1 and outputVar != -1) {
                    ;���᰻�� �Ҹ� ���ϰ� ������ ���̸� �ݱ�  
                    Sleep,1500
                    NA_MouseClick(activated_window,817,100)
                    Sleep,2000
                    break
                } else {
                    NA_MouseClick(activated_window,757,156) ;���� ���� 
                    Sleep,2000
                }
			}   
        }
    } else {
        ;����ó�� 
    }
    return
}

get_daliyReward(activated_window) {
    
    
    outputVar := NA_ImageSearch(activated_window,"C:\Users\aflhz\images\�����ִ���.bmp",50,131,66,149,115)
    if(outputVar != 1 and outputVar != -1) {
        Sleep,2000
        NA_MouseClick(activated_window,32,167) ; ���� ����
        Sleep,2500
        NA_MouseClick(activated_window,72,174) ; ù��° ���� ������ Ŭ�� 
        Sleep,1900
        
        
        loop {
            outputVar := NA_ImageSearch(activated_window,"C:\Users\aflhz\images\����1.bmp",726,320,780,350,110)
            if(outputVar != 1 and outputVar != -1) {
                x := NA_get_Xcoord(outputVar)
                y := NA_get_Ycoord(outputVar)
                NA_MouseClick(activated_window,x+6,y+6)
                Sleep,1700
            } else {
                NA_MouseClick(activated_window,81,277) ; �ι�° ���� ������ Ŭ�� 
                Sleep,1500
                break
            }
        }
        
        
        
        loop {
            outputVar := NA_ImageSearch(activated_window,"C:\Users\aflhz\images\����2.bmp",729,278,781,307,110)
            if(outputVar != 1 and outputVar != -1) {
                x := NA_get_Xcoord(outputVar)
                y := NA_get_Ycoord(outputVar)
                NA_MouseClick(activated_window,x+6,y+6)
                Sleep,1700
            } else {
                ;���� �ξ� �ޱ� 
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
        
                NA_MouseClick(activated_window,820,99) ;�ݱ�
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
        NA_MouseClick(activated_window,236,318) ;�ǹ�Ŭ��
        Sleep,1500
        NA_MouseClick(activated_window,336,418) ;���� ����
        Sleep,4500
        
        ;������ ���� 
        outputVar := NA_ImageSearch(activated_window,"C:\Users\aflhz\images\����.bmp",276,469,333,507,100)
        if(outputVar != 1 and outputVar != -1) {
            x := NA_get_Xcoord(outputVar)
            y := NA_get_Ycoord(outputVar)
            NA_MouseClick(activated_window,x+12,y+12)
            
            Sleep,3500
            
            ;������������ Ȯ�� ������ 
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
            ;��������ϱ� 
            Sleep,2000
            outputVar := NA_ImageSearch(activated_window,"C:\Users\aflhz\images\Ȯ��_������.bmp",433,217,512,309,110)
            if(outputVar != 1 and outputVar != -1) {
                x := NA_get_Xcoord(outputVar)
                y := NA_get_Ycoord(outputVar)
                NA_MouseClick(activated_window,233,504)
            } 
            
            Sleep,2000
            
            outputVar := NA_ImageSearch(activated_window,"C:\Users\aflhz\images\��������ȭ��.bmp",238,258,380,380,110)
            if(outputVar != 1 and outputVar != -1) {
                break
            } else {
                NA_MouseClick(activated_window,230,500)
                hap := hap + 1
                
                if(hap = 10) {
                    MsgBox,���� ����.. 
                    Sleep,10000
                    return
                }
            }
        }
        
        
        Sleep,3000
            
            
        } else {
            ;����ó��
        }
        
        
       
        
        ;�ݿ��� ���� 
        outputVar := NA_ImageSearch(activated_window,"C:\Users\aflhz\images\����.bmp",656,476,700,500,90)
        if(outputVar != 1 and outputVar != -1) {
            x := NA_get_Xcoord(outputVar)
            y := NA_get_Ycoord(outputVar)
            NA_MouseClick(activated_window,x+12,y+12)
            
            Sleep,4500
        

            ;������ ���Դ��� check
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
            ;��������ϱ� 
            Sleep,2000
            outputVar := NA_ImageSearch(activated_window,"C:\Users\aflhz\images\Ȯ��_�ݿ���.bmp",433,217,512,309,110)
            if(outputVar != 1 and outputVar != -1) {
                x := NA_get_Xcoord(outputVar)
                y := NA_get_Ycoord(outputVar)
                NA_MouseClick(activated_window,233,504)
            } 
            
            Sleep,2000
            
            outputVar := NA_ImageSearch(activated_window,"C:\Users\aflhz\images\��������ȭ��.bmp",238,258,380,380,110)
            if(outputVar != 1 and outputVar != -1) {
                break
            } else {
                NA_MouseClick(activated_window,230,500)
                hap := hap + 1
                
                if(hap = 10) {
                    MsgBox,���� ����.. 
                    Sleep,10000
                    return
                }
            }
        }
        

        
        
            Sleep,3000
            } else {
                ;����ó��
            }
        
        
           
        
        NA_MouseClick(activated_window,31,65) ;������ 
        
        
        Sleep,2000
        
        handle_error(activated_window)
        
    } else {
        ;����ó��
    }
    
    return
}

restart_ROK(activated_window) {
    
    loop {
        NA_MouseClick(activated_window,640,19) ;���ŷ �ݰ� 
        Sleep,3000
        NA_MouseClick(activated_window,314,274) ;�ٽÿ��� 
    
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
        
		
		;����â ���� â�� �� ���������� Ȯ�� 
		loop {
			Sleep,1000
			NA_MouseClick(activated_window,921,542) ;��������� ������ ���ְ�
			Sleep,1400
			outputVar := NA_ImageSearch(activated_window,"C:\Users\aflhz\images\������.bmp",674,521,718,557,100)
			if(outputVar != 1 and outputVar != -1) {
				NA_MouseClick(activated_window,777,537) ; ���Ϳ� ����
			
				Sleep,3500
			
				;â�� ����� ������ Ȯ�� 
				outputVar := NA_ImageSearch(activated_window,"C:\Users\aflhz\images\����âȮ��.bmp",732,312,794,378,40)
				if(outputVar != 1 and outputVar != -1) {
					break
				} else {
					MsgBox,����â ����� �� �ȶ�
					Sleep,10000
					return
				}
			}
		}
			
		
        
         Sleep,3200
            
		NA_MouseClick(activated_window,666,348) ; �������
		Sleep,2500
		NA_MouseClick(activated_window,758,141) ; ����
		Sleep,2500
		NA_MouseClick(activated_window,840,72) ; �ڷΰ��� 
		Sleep,2500
        
		NA_MouseClick(activated_window,665,457) ; ������ ���� 
		Sleep,2500
        
		NA_MouseClick(activated_window,700,191) ; ����� ���� 
		Sleep,2500
        
		loop {
			outputVar := NA_ImageSearch(activated_window,"C:\Users\aflhz\images\����.bmp",701,234,751,340,100)
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
		NA_MouseClick(activated_window,503,193) ; �Ϲ������� 
		Sleep,2500
		NA_MouseClick(activated_window,830,194) ; ���� ��μ����ϱ� Ŭ��  
		Sleep,4000
        
		;Ȯ���Ͽ� ���� 
		outputVar := NA_ImageSearch(activated_window,"C:\Users\aflhz\images\Ȯ��2.bmp",461,416,509,455,100)
		if(outputVar != 1 and outputVar != -1) {
			x := NA_get_Xcoord(outputVar)
			y := NA_get_Ycoord(outputVar)
			NA_MouseClick(activated_window,x+12,y+12)
		}
		
		Sleep,2400
		NA_MouseClick(activated_window,840,72) ; �ڷΰ��� 
		Sleep,2100
		NA_MouseClick(activated_window,840,72) ; �ڷΰ��� 
		Sleep,2100
        
    } else {
        MsgBox,����â ���� ������ ����.
        handle_error(activated_window)
        ;����ó��
    }
    
    return
}

get_vipPoint(activated_window) {
    
    Sleep,1000
    if (check_isInCastle(activated_window) == 1) {
        
        NA_MouseClick(activated_window,115,87) ;vip ���� 
        Sleep,3000
        
        outputVar := NA_ImageSearch(activated_window,"C:\Users\aflhz\images\�����ִ�vip����.bmp",595,295,635,319,100)
        if(outputVar != 1 and outputVar != -1) {
            
            NA_MouseClick(activated_window,817,100) ;������
            Sleep,2000

            
        } else {
			
            Sleep,1000
            NA_MouseClick(activated_window,768,182) ;����Ա� 
            Sleep,3000
            NA_MouseClick(activated_window,376,103) ;����Ŭ��
            Sleep,1300
            NA_MouseClick(activated_window,376,103) ;����Ŭ��
            Sleep,700
            NA_MouseClick(activated_window,376,103) ;����Ŭ��
            Sleep,1600
            NA_MouseClick(activated_window,700,340) ;����Ա� 
            Sleep,3000
            NA_MouseClick(activated_window,700,340) ;����Ա� 
            Sleep,3000
            NA_MouseClick(activated_window,700,340) ;����Ա� 
            Sleep,6000
            NA_MouseClick(activated_window,817,100) ;������
            Sleep,4000
            
            
            ;���ö� 5�� �Ա� 
            NA_MouseClick(activated_window,533,56) 
            Sleep,2000
            loop ,5 {
                NA_MouseClick(activated_window,726,177) 
                Sleep,1500
            }
            NA_MouseClick(activated_window,815,100) 
            Sleep,2500
        
        
        
            ;��ɰ� ����ġ �ø��� 
            outputVar := NA_ImageSearch(activated_window,"C:\Users\aflhz\images\������.bmp",674,521,718,557,100)
            if(outputVar != 1 and outputVar != -1) {
                NA_MouseClick(activated_window,841,538)
            } else {
                NA_MouseClick(activated_window,921,542) ;��������� ������ ���ְ�
                Sleep,1500
                NA_MouseClick(activated_window,841,538) ; ���Ϳ� ���� 
            }
            
            
        Sleep,4000
        NA_MouseClick(activated_window,152,283) ;ù��° ĳ�� 
        Sleep,2500
        
        outputVar := NA_ImageSearch(activated_window,"C:\Users\aflhz\images\����ġ�÷���.bmp",900,244,925,270,110)
        if(outputVar != 1 and outputVar != -1) {
            x := NA_get_Xcoord(outputVar)
            y := NA_get_Ycoord(outputVar)
            NA_MouseClick(activated_window,x+12,y+12)
        } else {
            Sleep,2500
            NA_MouseClick(activated_window,31,66) ;������
            return
        }
        
        Sleep,2000
        
        outputVar := NA_ImageSearch(activated_window,"C:\Users\aflhz\images\����ġâ�̶�����.bmp",110,70,190,125,100)
        if(outputVar != 1 and outputVar != -1) {
            loop,5 {
                Sleep,1500
                NA_MouseClick(activated_window,736,227) ;���ִٸ� ��ġå 5�� 
            }
            
            Sleep,2000
            NA_MouseClick(activated_window,820,100) ;â�ݰ�
            Sleep,2000
            NA_MouseClick(activated_window,31,66) ;������
            Sleep,2000
        } else {
            NA_MouseClick(activated_window,56,389) ;�ι���
        
            Sleep,2000
            outputVar := NA_ImageSearch(activated_window,"C:\Users\aflhz\images\����ġ�÷���.bmp",900,244,925,270,110)
            if(outputVar != 1 and outputVar != -1) {
                x := NA_get_Xcoord(outputVar)
                y := NA_get_Ycoord(outputVar)
                NA_MouseClick(activated_window,x+12,y+12)
                
                Sleep,2000
                outputVar := NA_ImageSearch(activated_window,"C:\Users\aflhz\images\����ġâ�̶�����.bmp",129,83,181,117,110)
                if(outputVar != 1 and outputVar != -1) {
                    loop,5 {
                        Sleep,1500
                        NA_MouseClick(activated_window,736,227) ;���ִٸ� ��ġå 5�� 
                    }
            
                    Sleep,1500
                    NA_MouseClick(activated_window,820,100) ;â�ݰ�
                    Sleep,1500
                    NA_MouseClick(activated_window,31,66) ;������
                    Sleep,1000
            
                }
                
            } else {
            Sleep,2500 ;������
            return
            }
            
        }
        ;��ɰ� ��ġ�ø��� ��
            
        }
        
        
        Sleep,2000
        
        handle_error(activated_window)
        
            
    } else {
        MsgBox,���ø��� ���� �������� ����.
        handle_error(activated_window)
        ;����ó��
    }
    
    return
}

changing_ID(activated_window) {
    
    Sleep,2500
    NA_MouseClick(activated_window,34,67) ;������ Ŭ�� 
    Sleep,2500
    NA_MouseClick(activated_window,743,430) ; ���� Ŭ��
    Sleep,4500
    
		
    ;���̵� �ٲٱ� 
    if(chaing_id_num = 4) {
		
        NA_MouseClick(activated_window,400,317) ; �����̵� Ŭ��
        Sleep,3000
        NA_MouseClick(activated_window,661,263) ;
        Sleep,3000
        NA_MouseClick(activated_window,601,266) ; 
        Sleep,5000
        
        NA_MouseClick(activated_window,308,372) ; ����� ���̵�� �̵� 
        Sleep,2000

    } else if(chaing_id_num = 6) {
        NA_MouseClick(activated_window,400,317) ; ���̵𺯰� Ŭ��
        Sleep,3000
        NA_MouseClick(activated_window,661,263) ;
        Sleep,3000
        NA_MouseClick(activated_window,601,266) ; 
        Sleep,5000
        
        NA_MouseClick(activated_window,308,316) ; �ٽ� aflhzv �Ƶ��� �̵� 
        Sleep,2000
    
        chaing_id_num := 0
    } 
    
    if(chaing_id_num = 5) {
        
        NA_MouseClick(activated_window,222,321) ; ���̵� ���� Ŭ�� 
    
        Sleep,5500
        ;�α��� 1���� üũ 
        outputVar := NA_ImageSearch(activated_window,"C:\Users\aflhz\images\�α���üũ.bmp",120,185,157,229,100)
        if(outputVar != 1 and outputVar != -1) {
            NA_MouseClick(activated_window,645,200)
            x := 645
            y := 200
            Sleep,2000
        }
    
        ;�α��� 2���� üũ 
        outputVar := NA_ImageSearch(activated_window,"C:\Users\aflhz\images\�α���üũ.bmp",441,193,502,224,100)
        if(outputVar != 1 and outputVar != -1) {
            NA_MouseClick(activated_window,285,200)
            x := 285
            y := 200
            Sleep,2000
        }
    }
    
    if(chaing_id_num= 1 or 2 or 3) {
        
		NA_MouseClick(activated_window,222,321) ; ���̵� ���� Ŭ�� 
		
		Sleep,5500
		;�α��� 1���� üũ 
		outputVar := NA_ImageSearch(activated_window,"C:\Users\aflhz\images\�α���üũ.bmp",120,185,157,229,100)
		if(outputVar != 1 and outputVar != -1) {
			NA_MouseClick(activated_window,645,200)
            x := 645
            y := 200
			Sleep,2000
		}
		
		;�α��� 2���� üũ 
		outputVar := NA_ImageSearch(activated_window,"C:\Users\aflhz\images\�α���üũ.bmp",441,193,502,224,100)
		if(outputVar != 1 and outputVar != -1) {
			NA_MouseClick(activated_window,300,300)
            x := 300
            y := 300
			Sleep,2000
		}
		
		;�α��� 3���� üũ 
		outputVar := NA_ImageSearch(activated_window,"C:\Users\aflhz\images\�α���üũ.bmp",118,300,159,339,100)
		if(outputVar != 1 and outputVar != -1) {
			NA_MouseClick(activated_window,650,300)
            x := 650
            y := 300
			Sleep,2000
		}
		
		;�α��� 4���� üũ 
		outputVar := NA_ImageSearch(activated_window,"C:\Users\aflhz\images\�α���üũ.bmp",471,300,515,338,100)
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
            MsgBox,�ɸ��ٲٴ°� ����
            Sleep,10000
            break
        }
        if (check_isInCastle(activated_window) == 1) { 
            break
        }
        
        Sleep,1000
        ;ĳ���ٲܶ� ���� ���� 
        outputVar := NA_ImageSearch(activated_window,"C:\Users\aflhz\images\����Ȯ��.bmp",439,403,517,442,100)
        if(outputVar != 1 and outputVar != -1) {
            Sleep,1000
            NA_MouseClick(activated_window,485,422)
            
            outputVar := NA_ImageSearch(activated_window,"C:\Users\aflhz\images\��.bmp",439,403,517,442,100)
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
        outputVar := NA_ImageSearch(activated_window,"C:\Users\aflhz\images\��ũ��Ž���׸�1.bmp",567,73,863,175,90)
        if(outputVar != 1 and outputVar != -1) {
            x := NA_get_Xcoord(outputVar)
            y := NA_get_Ycoord(outputVar)
            NA_MouseClick(activated_window,x+12,y+12)
            
            Sleep,2000
            outputVar := NA_ImageSearch(activated_window,"C:\Users\aflhz\images\����.bmp",359,279,805,349,110)
            if(outputVar != 1 and outputVar != -1) {
                x := NA_get_Xcoord(outputVar)
                y := NA_get_Ycoord(outputVar)
                NA_MouseClick(activated_window,x+12,y+12)
            }
            
            Sleep,4000
            
            WinActivate,%activated_window%
            
            Sleep,7000
            
            ; Ǯ������ ��� 
            loop {
                
            outputVar := NA_ImageSearch(activated_window,"C:\Users\aflhz\images\��ũ��Ȯ��.bmp",538,452,595,487,95)
            if(outputVar != 1 and outputVar != -1) {
                ;������Ǯ��
            } else {
                    break
                }
                Sleep,1000
            }
            
            
            
        }
        
        Sleep, 50
		
        outputVar := NA_ImageSearch(activated_window,"C:\Users\aflhz\images\��ũ��Ž���׸�1.bmp",567,73,863,175,90)
        if(outputVar != 1 and outputVar != -1) {
            x := NA_get_Xcoord(outputVar)
            y := NA_get_Ycoord(outputVar)
            NA_MouseClick(activated_window,x+12,y+12)
            
            Sleep,2000
            outputVar := NA_ImageSearch(activated_window,"C:\Users\aflhz\images\����.bmp",359,279,805,349,110)
            if(outputVar != 1 and outputVar != -1) {
                x := NA_get_Xcoord(outputVar)
                y := NA_get_Ycoord(outputVar)
                NA_MouseClick(activated_window,x+12,y+12)
            }
            
            Sleep,4000
            
            WinActivate,%activated_window%
            
            Sleep,7000
            
            ; Ǯ������ ��� 
            loop {
                
            outputVar := NA_ImageSearch(activated_window,"C:\Users\aflhz\images\��ũ��Ȯ��.bmp",538,452,595,487,95)
            if(outputVar != 1 and outputVar != -1) {
                ;������Ǯ��
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
                MsgBox, %activated_window% : ����ȭ���� �ƴմϴ�. hap = %hap%
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