import { ConnectButton } from "@rainbow-me/rainbowkit";
import type { NextPage } from "next";
import {
	usePetitionManagerGetGroupIdsForPetition,
	usePetitionManagerPetitionCreatedEvent,
	usePreparePetitionManagerCreatePetition,
} from "@/shared/generated";
import { useAccount, useContractWrite } from "wagmi";
import { Button, Container, Input } from "@chakra-ui/react";
import { useVC } from "@/shared/vc";
import { useState } from "react";
import { Identity } from "@semaphore-protocol/identity";
import { createIdentity } from "@/shared/semaphore";
import { useToast } from "@chakra-ui/react";

const petitionManagerAddress = "0x0DCd1Bf9A1b36cE34237eEaFef220932846BCD82";

const HomePage: NextPage = () => {
	const toast = useToast();

	const { address, isConnected } = useAccount();
	const { config } = usePreparePetitionManagerCreatePetition({
		args: [[1n], "test"],
		address: petitionManagerAddress,
	});
	const { write: createPetition } = useContractWrite(config);

	const { data: groupsIds } = usePetitionManagerGetGroupIdsForPetition({
		address: petitionManagerAddress,
		args: [1n],
	});

	usePetitionManagerPetitionCreatedEvent({
		address: petitionManagerAddress,
		listener: (args) => {
			console.log(args);
		},
	});

	const [id, setId] = useState<Identity | undefined>();
	const [password, setPassword] = useState("");
	const { data: vc, isSuccess: vcSuccess } = useVC();

	return (
		<Container my={5}>
			<ConnectButton />
			{isConnected && (
				<div>
					<ol>
						<li>
							Generate an identity:{" "}
							<Input
								onChange={(e) => setPassword(e.target.value)}
								value={password}
							/>
							<Button
								variant={"solid"}
								onClick={() => {
									setId(createIdentity(address as string, password));
									toast({
										title: "Identity Created",
										status: "success",
										duration: 2000,
										isClosable: true,
									});
								}}
							>
								generate identity from password
							</Button>
							<div>
								Identity:
								{JSON.stringify(id?.commitment)}
							</div>
						</li>
						<li>Join a group: </li>
						<li>Generate a proof of a vote</li>
						<li>Submit the vote</li>
						<li>Inspect the vote count</li>
					</ol>
					<button
						onClick={() => {
							createPetition?.();
						}}
					>
						create a petition
					</button>
					<div>Group IDs: {JSON.stringify(groupsIds)}</div>
				</div>
			)}
		</Container>
	);
};

export default HomePage;
