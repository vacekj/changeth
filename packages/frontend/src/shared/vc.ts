import { useSignTypedData } from "wagmi";
import { BigNumber, utils } from "ethers";

const domain = {
	name: "Changeth VC",
	version: "1",
	chainId: 80001,
	verifyingContract: "0xCcCCccccCCCCcCCCCCCcCcCccCcCCCcCcccccccC",
} as const;

// The named list of all type definitions
const types = {
	VC: [
		{ name: "idCommitment", type: "uint256" },
		{ name: "groupId", type: "uint256" },
	],
} as const;

type VC = {
	idCommitment: BigNumber;
	groupId: BigNumber;
};

export function useVC() {
	return useSignTypedData({
		domain,
		types,
	});
}
