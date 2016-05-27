require 'xlua'
require 'optim'
require 'image'
require 'cunn'
require 'cudnn'
local c = require 'trepl.colorize'
local json = require 'cjson'
torch.setdefaulttensortype('torch.FloatTensor')

---- LOADING NETWORK
net = torch.load'./nin_truncate_2.t7' -- change for each network (3 truncated nin + regular nin)
-- test function
collectgarbage()

function FoFo(dataset)
   print('<trainer> on ', dataset)
   for t = 1,dataset:size() do
   	collectgarbage()
      -- get new sample
      local input = dataset.data[t]
      local target = dataset.labels[t]

      -- test sample
      local pred = net:forward(input)
      forward.data[t] = pred
      forward.labels[t] = target
   end
end

---- OUTPUT FOR TRAINSET
trainData=torch.load('./provider_train.t7')
total=trainData.labels:size()[1]
print(total)
forward = {
    data = torch.Tensor(total, 256*14*14), --- 100 for regular nin, 384*7*7 for truncated 1, 256*14*14 for truncated 2, 96*28*28 for truncated 3
    labels = torch.Tensor(total),
    size = function() return total end,
}

FoFo(trainData)
torch.save('output_nin__truncate2_train.t7',forward) -- must be changed for every network

---- OUTPUT FOR TESTSET
testData=torch.load('./provider_test.t7') 
total=testData.labels:size()[1]
print(total)
forward = {
    data = torch.Tensor(total, 256*14*14), --- 100 for regular nin, 384*7*7 for truncated 1, 256*14*14 for truncated 2, 96*28*28 for truncated 3
    labels = torch.Tensor(total),
    size = function() return total end,
}
collectgarbage()
FoFo(testData)

torch.save('output_nin_truncate2_test.t7',forward) -- must be changed for every network
