#-*-coding:utf-8-*-
import numpy as np
import matplotlib.pyplot as plt
import os

caffe_root = '/Users/mengqingjiang/Desktop/file/Project/DL/caffe/'

import sys
sys.path.append(caffe_root+'python')

import caffe

def getImageList(dir,wildcard):
	files = os.listdir(dir)
	exts = wildcard.split(" ")
	ImageList = []
	for name in files:
		fullname=os.path.join(dir,name)
		for ext in exts:
			if(name.endswith(ext)):
				ImageList.append(name)
				break
	return ImageList

def getResultVector(imagename,deploy,model):
	#################################################################
	#### 用classifier接口 ####

	net = caffe.Classifier(deploy, model,
	 channel_swap=(2,1,0),
	 input_scale=255)

	#net.set_phase_test()
	#net.set_mode_cpu()
	input_image = caffe.io.load_image(TEST_ROOT+imagename)
	#input_image = caffe.io.load_image('/Users/mengqingjiang/Desktop/92.jpg')

	prediction = net.predict([input_image]) #预测可以输入任何大小的图像，caffe net 会自动调整。
	#print 'prediction shape:', prediction[0].shape
	#print prediction[0]
	#plt.bar(np.arange(10),prediction[0])
	#plt.show()

	return prediction[0]

	##################################################################
	#### 用net接口 ####

	# net = caffe.Net(deploy, model, caffe.TEST)

	# # 批处理量
	# batch_size = 10
	# # 图片裁剪大小
	# crop_dims = (227, 227)

	# # 'data'对应于deploy文件：
	# # input: "data"
	# # input_dim: 10
	# # input_dim: 3
	# # input_dim: 227
	# # input_dim: 227
	# transformer = caffe.io.Transformer({'data': net.blobs['data'].data.shape})
	# # python读取的图片文件格式为H×W×K，需转化为K×H×W
	# transformer.set_transpose('data', (2, 0, 1))
	# # python中将图片存储为[0, 1]，而caffe中将图片存储为[0, 255]，
	# # 所以需要一个转换
	# transformer.set_raw_scale('data', 255)
	# # caffe中图片是BGR格式，而原始格式是RGB，所以要转化
	# transformer.set_channel_swap('data', (2, 1, 0))
	# # 将输入图片格式转化为合适格式（与deploy文件相同）
	# net.blobs['data'].reshape(batch_size, 3, crop_dims[0], crop_dims[1])



	# # /caffe/python/caffe/io.py
	# img = caffe.io.load_image('/Users/mengqingjiang/Desktop/9.jpg')
	# # 读取的图片文件格式为H×W×K，需注意

	# # 图片维度（高、宽）
	# img_shape = np.array(img.shape)
	# # 裁剪的大小（高、宽）
	# crop_dims = np.array(crop_dims)

	# # 这里使用的图片高度全部固定为32，长度可变，最小为96
	# # 裁剪起点为0，终点为w_range
	# w_range = img_shape[1] - crop_dims[1]

	# # 从左往右剪一遍，再从右往左剪一遍，步长为96/4=24
	# k_range = range(0, w_range + 1, crop_dims[1] / 4) + range(w_range, 1, -crop_dims[1] / 4)
	# # 一张图片需要识别次数为_batch_size
	# _batch_size = max(len(k_range), 1)
	# net.blobs['data'].reshape(_batch_size, 3, crop_dims[0], crop_dims[1])

	# # 数据处理，输入
	# for ik, k in enumerate(k_range):
	#     # 裁剪图片
	#     crop_img = img[:, k:k + crop_dims[1], :]
	#     # 数据输入
	#     net.blobs['data'].data[ik] = transformer.preprocess('data', crop_img)


	# # 前向迭代，即分类
	# out = net.forward()
	# # 每一次分类的概率分布叠加
	# pridects = np.sum(out['prob'], axis=0)
	# # 取最大的概率分布为最终结果
	# pridect = pridects.argmax()

	# print pridect

	# plt.bar(np.arange(10),pridects)
	# plt.show()

	# 上述'prob'来源于deploy文件：
	# layer {
	#   name: "prob"
	#   type: "Softmax"
	#   bottom: "ip2"
	#   top: "prob"
	# }
	
	#return pridect

# 输出图片的类别
def classification(ImageList):
	# caffemodel文件
	MODEL_FILE = caffe_root+'examples/ADS_Project_2/caffe_alexnet_train_hash16_iter_1000.caffemodel'
	# deploy文件，参考/caffe/models/bvlc_alexnet/deploy.prototxt
	DEPLOY_FILE = caffe_root+'examples/ADS_Project_2/deploy_classification.prototxt'

	# 输出文件
	outfile = 'alexnet_classification.txt'
	file = open(outfile,"w")
	if not file:
		print ("cannot open the file %s for writing" % outfile)

	for image in ImageList:
		result = getResultVector(image, DEPLOY_FILE, MODEL_FILE).argmax()
		file.write(image + ' ' + str(result) + '\n')
	file.close()

# 输出图片的哈希码
def hash(ImageList):
		# caffemodel文件
	MODEL_FILE = caffe_root+'examples/ADS_Project_2/caffe_alexnet_train_hash16_iter_1000.caffemodel'
	# deploy文件，参考/caffe/models/bvlc_alexnet/deploy.prototxt
	DEPLOY_FILE = caffe_root+'examples/ADS_Project_2/deploy_hash16.prototxt'

	# 输出文件
	outfile = 'alexnet_hash16_train.txt'
	file = open(outfile,"w")
	if not file:
		print ("cannot open the file %s for writing" % outfile)
	for image in ImageList:
		result = getResultVector(image, DEPLOY_FILE, MODEL_FILE)
		# 将向量中的小数区分为0或者1
		hashcode = ''
		print result
		for each in result:
			if each >= 0.5 :
				hashcode += '1' 
			else:
				hashcode += '0'
		print hashcode
		file.write(image + ' ' + hashcode + '\n')
	file.close()

# 输出图片的特征向量
def feature(ImageList):
	# caffemodel文件
	MODEL_FILE = caffe_root+'examples/ADS_Project_2/caffe_alexnet_train_hash16_iter_1000.caffemodel'
	# deploy文件，参考/caffe/models/bvlc_alexnet/deploy.prototxt
	DEPLOY_FILE = caffe_root+'examples/ADS_Project_2/deploy_feature4096.prototxt'
	# 输出文件
	outfile = 'alexnet_feature4096.txt'
	file = open(outfile,"w")
	if not file:
		print ("cannot open the file %s for writing" % outfile)

	for image in ImageList:
		result = getResultVector(image, DEPLOY_FILE, MODEL_FILE)
		file.write(image)
		
		for each in result:
			file.write(' '+str(each))
		file.write('\n')
	file.close()



# 测试图片存放文件夹
TEST_ROOT = caffe_root+'data/ADS_Project_2_re/train4613/'
wildcard = ".JPEG .jpg"
# 获取所有图片的名称列表
ImageList = getImageList(TEST_ROOT, wildcard)

# 设置CPU模式
caffe.set_mode_cpu()
# 设置GPU模式
# caffe.set_mode_gpu()

#classification(ImageList)
hash(ImageList)
#feature(ImageList)





