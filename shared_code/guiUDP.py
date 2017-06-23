# -*- coding: utf-8 -*-
"""
Created on Mon Jun 12 22:06:13 2017

@author: anton
"""

import socket
import numpy as np 
import scipy as sp
import time
from six.moves import xrange  # pylint: disable=redefined-builtin
import threading
import struct
import matplotlib as plt
from matplotlib.backends.backend_tkagg import FigureCanvasTkAgg, NavigationToolbar2TkAgg
import tkinter as tk
from tkinter import ttk
from tkinter import simpledialog
import matplotlib.image as mpimg
import matplotlib.patches as patches
import matplotlib.collections as collections 

class UDPsend(object):
    def __init__(self):
        self.sock = socket.socket(socket.AF_INET, # Internet
                                  socket.SOCK_DGRAM) # UDP
        
    def send(self,msg,addr=('192.168.42.1',12354)):
        self.sock.sendto(msg,addr)
    
    def closeSocket(self):
        self.sock.shutdown()
        self.sock.close()
        
    def reOpenSocket(self):
        self.sock = socket.socket(socket.AF_INET, # Internet
                                  socket.SOCK_DGRAM) # UDP
        
class UDPreceive(object):
    def __init__(self,fileN,portN=11000):
        self.sock = socket.socket(socket.AF_INET, # Internet
                                  socket.SOCK_DGRAM) # UDP
        self.sock.bind(("",portN))
        self.data=""
        self.dataRead = False
        self.t1 = None
        self.rec = True
        self.file = open(fileN,'w')
    
    def reOpenSocket(self,portN=11000):
        self.sock = socket.socket(socket.AF_INET, # Internet
                                  socket.SOCK_DGRAM) # UDP
        self.sock.bind(("",portN))
        self.file = open(fileN,'w')
        self.rec = True
        self.startThread()
        
    def _parseData(self,unparsed):
        try:
            self.file.write(unparsed)
        except ValueError:
            pass
    
    def __receiveData(self):
        while self.rec:
            data, addr = self.sock.recvfrom(1024)
            if data != None:
                self._parseData(data.decode("utf-8"))
                
    def startThread(self):
        self.t1 = threading.Thread(target=self.__receiveData, args=[])
        self.t1.daemon = True
        self.t1.start()
    
    def closeSocket(self):
        self.rec = False
        time.sleep(1)
        self.sock.shutdown(socket.SHUT_RDWR)
        self.sock.close()


class UDPapp(object):
    def __init__(self,file):
        self.theSend = UDPsend()
        self.root = tk.Tk()
        self.stopR = True
        self.record = tk.Button(self.root,text='close',command=self.startStop)
        self.record.pack()
        self.theRec = UDPreceive(file)
        self.theRec.startThread()
        self.root.protocol("WM_DELETE_WINDOW", self.theRec.closeSocket)
        self.root.mainloop()
        
    def startStop(self):
        self.theRec.file.close()
        self.theRec.closeSocket()
        self.root.destroy()



f ='dataSaved.csv'
app = UDPapp(f)
