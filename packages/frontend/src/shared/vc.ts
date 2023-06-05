import { useSignTypedData } from "wagmi";

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
	idCommitment: bigint;
	groupId: bigint;
};

export function useVC() {
	return useSignTypedData({
		domain,
		types,
	});
}
