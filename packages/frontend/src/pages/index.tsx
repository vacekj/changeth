import { ConnectButton } from "@rainbow-me/rainbowkit";
import type { NextPage } from "next";
import {
  usePetitionManagerGetGroupIdsForPetition,
  usePetitionManagerPetitionCreatedEvent,
  usePetitionManagerPetitions,
  usePetitionManagerRead,
  usePreparePetitionManagerCreatePetition,
} from "../shared/generated";
import { useContractWrite } from "wagmi";
import { BigNumber } from "ethers";
import { Container } from "@chakra-ui/react";

const petManAddy = "0x0DCd1Bf9A1b36cE34237eEaFef220932846BCD82";
const HomePage: NextPage = () => {
  const { config } = usePreparePetitionManagerCreatePetition({
    args: [[BigNumber.from(1)], "test"],
    address: petManAddy,
  });
  const { isSuccess, write } = useContractWrite(config);

  const { data: petition } = usePetitionManagerGetGroupIdsForPetition({
    address: petManAddy,
    args: [BigNumber.from(1)],
  });

  usePetitionManagerPetitionCreatedEvent({
    address: petManAddy,
    listener: (args) => {
      console.log(args);
    },
  });

  return (
    <Container>
      <ConnectButton />
      <ol>
        <li>Generate an identity</li>
        <li>Join a group</li>
        <li>Generate a proof of a vote</li>
        <li>Submit the vote</li>
        <li>Inspect the vote count</li>
      </ol>
      <button
        onClick={() => {
          write?.();
        }}
      >
        create a petition
      </button>
      <ul>
        <li> {isSuccess ? "succ" : "nope"}</li>
      </ul>
      <div>{JSON.stringify(petition)}</div>
    </Container>
  );
};

export default HomePage;
