require 'nn'
--- File to create a train and final dataset from
--- several (10) Imagenet folders
--- train and test dataset
--- from a train and a test folder
--- with files 
--- Use the file twice (by switching directory)


net = torch.load'./nin_nobn_final.t7':unpack()
directory = 'train'

if directory == 'train' then

----- LOADING
    total = 0
    Dir = {}
    for dir in paths.iterdirs("./dataset_final/train") do
        table.insert(Dir, dir)
        files = {}
        for file in paths.files(paths.concat('./dataset_final/train', dir)) do
           if file:find('JPEG' .. '$') then
              table.insert(files, 1)
           end
        end
       
        if #files == 0 then
           error('given directory doesnt contain any files of type: ')
        end

        total = total + #files
        collectgarbage()
    end

    imagesAll = torch.Tensor(total,3,224,224) 
    labelsAll = torch.Tensor(total)
    compteur = 0
    NumberOfImages = {0}
    for dir in paths.iterdirs("./dataset_final/train") do
        compteur = compteur +1
        files = {}
        for file in paths.files(paths.concat('./dataset_final/train', dir)) do
           if file:find('JPEG' .. '$') then
              table.insert(files, paths.concat(paths.concat('./dataset_final/train',dir), file))
           end
        end
       
        if #files == 0 then
           error('given directory doesnt contain any files of type: ')
        end

---- CREATING DATASET

        lastElement = NumberOfImages[#NumberOfImages]
        table.insert(NumberOfImages, #files + lastElement)
        for i=1,(#files) do
            temp = image.load(files[i])
            temp2 = torch.Tensor(3,224,224) 
            if (temp:size()[1]==1) then
                temp2[{{1},{},{}}] = temp
                temp2[{{2},{},{}}] = temp
                temp2[{{3},{},{}}] = temp
            else 
                temp2 = temp
            end
            imagesAll[i+lastElement] = temp2 
            labelsAll[i+lastElement] = compteur
            --labelsAll[i+lastElement] = dico[Dir[compteur]]
        end
        collectgarbage()
    end

    print(Dir)
    print('total', total)

    trainData = {
        data = torch.Tensor(total, 3, 224, 224),
        labels = torch.Tensor(total),
        size = function() return total end,
    }

---- normalization
    for i=1,total do
       trainData.data[i] = imagesAll[i]
       trainData.labels[i] = labelsAll[i]
       for j=1,3 do trainData.data[i]:select(2,j):add(-net.transform.mean[j]):div(net.transform.std[j]) end
    end
    collectgarbage()
    print '==> training data'
    torch.save('provider_train.t7',trainData)

elseif directory == 'test' then

    total = 0
    Dir = {}
    for dir in paths.iterdirs("./dataset_final/val") do
        table.insert(Dir, dir)
        files = {}
        for file in paths.files(paths.concat('./dataset_final/val', dir)) do
           if file:find('JPEG' .. '$') then
              table.insert(files, 1)
           end
        end       
        if #files == 0 then
           error('given directory doesnt contain any files of type: ')
        end

        total = total + #files
        collectgarbage()
    end


    imagesAll = torch.Tensor(total,3,224,224) 
    labelsAll = torch.Tensor(total)
    compteur = 0
    NumberOfImages = {0}
    for dir in paths.iterdirs("./dataset_final/val") do
        compteur = compteur +1
        files = {}
        for file in paths.files(paths.concat('./dataset_final/val', dir)) do
           if file:find('JPEG' .. '$') then
              table.insert(files, paths.concat(paths.concat('./dataset_final/val',dir), file))
           end
        end
       
        if #files == 0 then
           error('given directory doesnt contain any files of type: ')
        end


        lastElement = NumberOfImages[#NumberOfImages]
        table.insert(NumberOfImages, #files + lastElement)
        for i=1,(#files) do
            temp = image.load(files[i])
            temp2 = torch.Tensor(3,224,224) 
            if (temp:size()[1]==1) then
                temp2[{{1},{},{}}] = temp
                temp2[{{2},{},{}}] = temp
                temp2[{{3},{},{}}] = temp
            else 
                temp2 = temp
            end
            imagesAll[i+lastElement] = temp2 
            labelsAll[i+lastElement] = compteur
            --labelsAll[i+lastElement] = dico[Dir[compteur]]
        end
        collectgarbage()
    end
    print(Dir)
    print('total', total)

    testData = {
        data = torch.Tensor(total, 3, 224, 224),
        labels = torch.Tensor(total),
        size = function() return total end,
    }

    for i=1,total do
       testData.data[i] = imagesAll[i]
       testData.labels[i] = labelsAll[i]
       for j=1,3 do testData.data[i]:select(2,j):add(-net.transform.mean[j]):div(net.transform.std[j]) end
    end

    collectgarbage()
    print '==> testing data'
    torch.save('provider_test.t7',testData)

end







