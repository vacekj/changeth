import { defineConfig } from "@wagmi/cli";
import { foundry } from "@wagmi/cli/plugins";
import { react } from "@wagmi/cli/plugins";

export default defineConfig({
	out: "src/shared/generated.ts",
	contracts: [],
	plugins: [
		react({
			useContractFunctionRead: true,
			useContractEvent: true,
			usePrepareContractFunctionWrite: true,
		}),
		foundry({
			project: "../contracts",
		}),
	],
});
