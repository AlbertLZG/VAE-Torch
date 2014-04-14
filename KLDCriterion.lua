local KLDCriterion, parent = torch.class('nn.KLDCriterion', 'nn.Criterion')

function KLDCriterion:updateOutput(input, target)
    -- 0.5 * sum(1 + log(sigma^2) - mu^2 - sigma^2)
    -- print("mu",torch.norm(input[1]))
    -- print("sigma", torch.norm(torch.mul(input[2],0.5)))

    self.output = 0.5 * torch.sum(torch.add(input[2],1):add(-1,torch.pow(input[1],2)):add(-1,torch.exp(input[2])))
    return self.output
end

function KLDCriterion:updateGradInput(input, target)
	self.gradInput = {}
    self.gradInput[1] = (-input[1]):clone()
    self.gradInput[2] = (-torch.exp(input[2])):add(1):mul(0.5)

    return self.gradInput
end
