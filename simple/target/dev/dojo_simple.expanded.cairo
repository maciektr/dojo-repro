mod dojo_simple {
    #[derive(Drop, Serde, Clone)]
    pub struct GameContextDetails {
        pub name: ByteArray,
        pub description: ByteArray,
        pub id: Option<u32>,
        pub context: Span<GameContext>,
    }

    #[derive(Drop, Serde, Clone)]
    pub struct GameContext {
        pub name: ByteArray,
        pub value: ByteArray,
    }

    #[starknet::interface]
    pub trait MyInterface<T> {
        fn system_1(ref self: T, k: felt252, v: felt252);
        fn system_2(ref self: T, k: felt252) -> felt252;
        fn system_3(ref self: T, k: felt252, v: u32);
        fn system_4(ref self: T, k: felt252);
        fn system_dbg(
            ref self: T, objective_ids: Option<Span<u32>>, game_context: Option<GameContextDetails>,
        );
    }
    impl GameContextDetailsDrop<> of core::traits::Drop<GameContextDetails>;
    impl GameContextDetailsSerde<> of core::serde::Serde<GameContextDetails> {
        fn serialize(self: @GameContextDetails, ref output: core::array::Array<felt252>) {
            core::serde::Serde::<ByteArray>::serialize(self.name, ref output);
            core::serde::Serde::<ByteArray>::serialize(self.description, ref output);
            core::serde::Serde::<Option<u32>>::serialize(self.id, ref output);
            core::serde::Serde::<Span<GameContext>>::serialize(self.context, ref output)
        }
        fn deserialize(
            ref serialized: core::array::Span<felt252>,
        ) -> core::option::Option<GameContextDetails> {
            let name = core::internal::InferDestruct::<
                ByteArray,
            > { value: core::serde::Serde::<ByteArray>::deserialize(ref serialized)? };
            let description = core::internal::InferDestruct::<
                ByteArray,
            > { value: core::serde::Serde::<ByteArray>::deserialize(ref serialized)? };
            let id = core::internal::InferDestruct::<
                Option<u32>,
            > { value: core::serde::Serde::<Option<u32>>::deserialize(ref serialized)? };
            let context = core::internal::InferDestruct::<
                Span<GameContext>,
            > { value: core::serde::Serde::<Span<GameContext>>::deserialize(ref serialized)? };
            core::option::Option::Some(
                GameContextDetails {
                    name: name.value,
                    description: description.value,
                    id: id.value,
                    context: context.value,
                },
            )
        }
    }
    impl GameContextDetailsClone<> of core::clone::Clone<GameContextDetails> {
        fn clone(self: @GameContextDetails) -> GameContextDetails {
            let name = core::internal::InferDestruct::<
                ByteArray,
            > { value: core::clone::Clone::<ByteArray>::clone(self.name) };
            let description = core::internal::InferDestruct::<
                ByteArray,
            > { value: core::clone::Clone::<ByteArray>::clone(self.description) };
            let id = core::internal::InferDestruct::<
                Option<u32>,
            > { value: core::clone::Clone::<Option<u32>>::clone(self.id) };
            let context = core::internal::InferDestruct::<
                Span<GameContext>,
            > { value: core::clone::Clone::<Span<GameContext>>::clone(self.context) };
            GameContextDetails {
                name: name.value,
                description: description.value,
                id: id.value,
                context: context.value,
            }
        }
    }
    impl GameContextDrop<> of core::traits::Drop<GameContext>;
    impl GameContextSerde<> of core::serde::Serde<GameContext> {
        fn serialize(self: @GameContext, ref output: core::array::Array<felt252>) {
            core::serde::Serde::<ByteArray>::serialize(self.name, ref output);
            core::serde::Serde::<ByteArray>::serialize(self.value, ref output)
        }
        fn deserialize(
            ref serialized: core::array::Span<felt252>,
        ) -> core::option::Option<GameContext> {
            let name = core::internal::InferDestruct::<
                ByteArray,
            > { value: core::serde::Serde::<ByteArray>::deserialize(ref serialized)? };
            let value = core::internal::InferDestruct::<
                ByteArray,
            > { value: core::serde::Serde::<ByteArray>::deserialize(ref serialized)? };
            core::option::Option::Some(GameContext { name: name.value, value: value.value })
        }
    }
    impl GameContextClone<> of core::clone::Clone<GameContext> {
        fn clone(self: @GameContext) -> GameContext {
            let name = core::internal::InferDestruct::<
                ByteArray,
            > { value: core::clone::Clone::<ByteArray>::clone(self.name) };
            let value = core::internal::InferDestruct::<
                ByteArray,
            > { value: core::clone::Clone::<ByteArray>::clone(self.value) };
            GameContext { name: name.value, value: value.value }
        }
    }
    #[derive(Introspect, Serde, Drop, DojoStore)]
    pub struct M<> {
        #[key]
        pub k: felt252,
        pub v: felt252,
    }
    #[derive(Introspect, Serde, Drop, DojoStore)]
    pub struct MValue {
        pub v: felt252,
    }

    type MKeyType = felt252;

    pub impl MKeyParser of dojo::model::model::KeyParser<M, MKeyType> {
        #[inline(always)]
        fn parse_key(self: @M) -> MKeyType {
            *self.k
        }
    }

    impl MModelValueKey of dojo::model::model_value::ModelValueKey<MValue, MKeyType> {}

    pub impl MDefinition = m_M_definition::MDefinitionImpl<M>;
    pub impl MModelValueDefinition = m_M_definition::MDefinitionImpl<MValue>;

    pub impl MModelParser of dojo::model::model::ModelParser<M> {
        fn deserialize(ref keys: Span<felt252>, ref values: Span<felt252>) -> Option<M> {
            let k = core::serde::Serde::<felt252>::deserialize(ref keys)?;

            let v = dojo::storage::DojoStore::<felt252>::dojo_deserialize(ref values)?;

            Some(M { k, v })
        }
        fn serialize_keys(self: @M) -> Span<felt252> {
            let mut serialized = core::array::ArrayTrait::new();
            dojo::storage::DojoStore::dojo_serialize(self.k, ref serialized);

            core::array::ArrayTrait::span(@serialized)
        }
        fn serialize_values(self: @M) -> Span<felt252> {
            let mut serialized = core::array::ArrayTrait::new();
            dojo::storage::DojoStore::dojo_serialize(self.v, ref serialized);

            core::array::ArrayTrait::span(@serialized)
        }
    }

    pub impl MModelValueParser of dojo::model::model_value::ModelValueParser<MValue> {
        fn deserialize(ref values: Span<felt252>) -> Option<MValue> {
            dojo::storage::DojoStore::<MValue>::dojo_deserialize(ref values)
        }
        fn serialize_values(self: @MValue) -> Span<felt252> {
            let mut serialized = core::array::ArrayTrait::new();
            dojo::storage::DojoStore::dojo_serialize(self.v, ref serialized);

            core::array::ArrayTrait::span(@serialized)
        }
    }

    // Note that MDojoStore is implemented through the DojoStore derive attribute
    // as any structs.

    pub impl MModelImpl = dojo::model::model::ModelImpl<M>;
    pub impl MModelValueImpl = dojo::model::model_value::ModelValueImpl<MValue>;
    #[derive(Introspect, Serde, Drop)]
    pub struct E<> {
        #[key]
        pub k: felt252,
        pub v: u32,
    } // EventValue on it's own does nothing since events are always emitted and
    // never read from the storage. However, it's required by the ABI to
    // ensure that the event definition contains both keys and values easily distinguishable.
    // Only derives strictly required traits.
    #[derive(Introspect, Serde, Drop)]
    pub struct EValue {
        pub v: u32,
    }

    pub impl EDefinition of dojo::event::EventDefinition<E> {
        #[inline(always)]
        fn name() -> ByteArray {
            "E"
        }
    }

    pub impl EModelParser of dojo::model::model::ModelParser<E> {
        fn deserialize(ref keys: Span<felt252>, ref values: Span<felt252>) -> Option<E> {
            let mut serialized: Array<felt252> = keys.into();
            serialized.append_span(values);
            let mut data = serialized.span();

            // always use Serde as event data are never stored in the world storage.
            core::serde::Serde::<E>::deserialize(ref data)
        }
        fn serialize_keys(self: @E) -> Span<felt252> {
            let mut serialized = core::array::ArrayTrait::new();
            core::serde::Serde::serialize(self.k, ref serialized);

            core::array::ArrayTrait::span(@serialized)
        }
        fn serialize_values(self: @E) -> Span<felt252> {
            let mut serialized = core::array::ArrayTrait::new();
            core::serde::Serde::serialize(self.v, ref serialized);

            core::array::ArrayTrait::span(@serialized)
        }
    }

    pub impl EEventImpl = dojo::event::event::EventImpl<E>;
    #[derive(Introspect, Serde, Drop)]
    pub struct EH<> {
        #[key]
        pub k: felt252,
        pub v: u32,
    } // EventValue on it's own does nothing since events are always emitted and
    // never read from the storage. However, it's required by the ABI to
    // ensure that the event definition contains both keys and values easily distinguishable.
    // Only derives strictly required traits.
    #[derive(Introspect, Serde, Drop)]
    pub struct EHValue {
        pub v: u32,
    }

    pub impl EHDefinition of dojo::event::EventDefinition<EH> {
        #[inline(always)]
        fn name() -> ByteArray {
            "EH"
        }
    }

    pub impl EHModelParser of dojo::model::model::ModelParser<EH> {
        fn deserialize(ref keys: Span<felt252>, ref values: Span<felt252>) -> Option<EH> {
            let mut serialized: Array<felt252> = keys.into();
            serialized.append_span(values);
            let mut data = serialized.span();

            // always use Serde as event data are never stored in the world storage.
            core::serde::Serde::<EH>::deserialize(ref data)
        }
        fn serialize_keys(self: @EH) -> Span<felt252> {
            let mut serialized = core::array::ArrayTrait::new();
            core::serde::Serde::serialize(self.k, ref serialized);

            core::array::ArrayTrait::span(@serialized)
        }
        fn serialize_values(self: @EH) -> Span<felt252> {
            let mut serialized = core::array::ArrayTrait::new();
            core::serde::Serde::serialize(self.v, ref serialized);

            core::array::ArrayTrait::span(@serialized)
        }
    }

    pub impl EHEventImpl = dojo::event::event::EventImpl<EH>;
    #[doc(group: "dispatchers")]
    pub trait MyInterfaceDispatcherTrait<T> {
        fn system_1(self: T, k: felt252, v: felt252);
        fn system_2(self: T, k: felt252) -> felt252;
        fn system_3(self: T, k: felt252, v: u32);
        fn system_4(self: T, k: felt252);
        fn system_dbg(
            self: T, objective_ids: Option<Span<u32>>, game_context: Option<GameContextDetails>,
        );
    }

    #[doc(group: "dispatchers")]
    #[derive(Copy, Drop, starknet::Store, Serde)]
    pub struct MyInterfaceDispatcher {
        pub contract_address: starknet::ContractAddress,
    }

    #[doc(group: "dispatchers")]
    impl MyInterfaceDispatcherImpl of MyInterfaceDispatcherTrait<MyInterfaceDispatcher> {
        fn system_1(self: MyInterfaceDispatcher, k: felt252, v: felt252) {
            let mut __calldata__ = core::traits::Default::default();
            core::serde::Serde::<felt252>::serialize(@k, ref __calldata__);
            core::serde::Serde::<felt252>::serialize(@v, ref __calldata__);

            let mut __dispatcher_return_data__ = starknet::syscalls::call_contract_syscall(
                self.contract_address,
                selector!("system_1"),
                core::array::ArrayTrait::span(@__calldata__),
            );
            let mut __dispatcher_return_data__ = starknet::SyscallResultTrait::unwrap_syscall(
                __dispatcher_return_data__,
            );
            ()
        }
        fn system_2(self: MyInterfaceDispatcher, k: felt252) -> felt252 {
            let mut __calldata__ = core::traits::Default::default();
            core::serde::Serde::<felt252>::serialize(@k, ref __calldata__);

            let mut __dispatcher_return_data__ = starknet::syscalls::call_contract_syscall(
                self.contract_address,
                selector!("system_2"),
                core::array::ArrayTrait::span(@__calldata__),
            );
            let mut __dispatcher_return_data__ = starknet::SyscallResultTrait::unwrap_syscall(
                __dispatcher_return_data__,
            );
            core::option::OptionTrait::expect(
                core::serde::Serde::<felt252>::deserialize(ref __dispatcher_return_data__),
                'Returned data too short',
            )
        }
        fn system_3(self: MyInterfaceDispatcher, k: felt252, v: u32) {
            let mut __calldata__ = core::traits::Default::default();
            core::serde::Serde::<felt252>::serialize(@k, ref __calldata__);
            core::serde::Serde::<u32>::serialize(@v, ref __calldata__);

            let mut __dispatcher_return_data__ = starknet::syscalls::call_contract_syscall(
                self.contract_address,
                selector!("system_3"),
                core::array::ArrayTrait::span(@__calldata__),
            );
            let mut __dispatcher_return_data__ = starknet::SyscallResultTrait::unwrap_syscall(
                __dispatcher_return_data__,
            );
            ()
        }
        fn system_4(self: MyInterfaceDispatcher, k: felt252) {
            let mut __calldata__ = core::traits::Default::default();
            core::serde::Serde::<felt252>::serialize(@k, ref __calldata__);

            let mut __dispatcher_return_data__ = starknet::syscalls::call_contract_syscall(
                self.contract_address,
                selector!("system_4"),
                core::array::ArrayTrait::span(@__calldata__),
            );
            let mut __dispatcher_return_data__ = starknet::SyscallResultTrait::unwrap_syscall(
                __dispatcher_return_data__,
            );
            ()
        }
        fn system_dbg(
            self: MyInterfaceDispatcher,
            objective_ids: Option<Span<u32>>,
            game_context: Option<GameContextDetails>,
        ) {
            let mut __calldata__ = core::traits::Default::default();
            core::serde::Serde::<Option<Span<u32>>>::serialize(@objective_ids, ref __calldata__);
            core::serde::Serde::<
                Option<GameContextDetails>,
            >::serialize(@game_context, ref __calldata__);

            let mut __dispatcher_return_data__ = starknet::syscalls::call_contract_syscall(
                self.contract_address,
                selector!("system_dbg"),
                core::array::ArrayTrait::span(@__calldata__),
            );
            let mut __dispatcher_return_data__ = starknet::SyscallResultTrait::unwrap_syscall(
                __dispatcher_return_data__,
            );
            ()
        }
    }

    #[doc(group: "dispatchers")]
    #[derive(Copy, Drop, starknet::Store, Serde)]
    pub struct MyInterfaceLibraryDispatcher {
        pub class_hash: starknet::ClassHash,
    }

    #[doc(group: "dispatchers")]
    impl MyInterfaceLibraryDispatcherImpl of MyInterfaceDispatcherTrait<
        MyInterfaceLibraryDispatcher,
    > {
        fn system_1(self: MyInterfaceLibraryDispatcher, k: felt252, v: felt252) {
            let mut __calldata__ = core::traits::Default::default();
            core::serde::Serde::<felt252>::serialize(@k, ref __calldata__);
            core::serde::Serde::<felt252>::serialize(@v, ref __calldata__);

            let mut __dispatcher_return_data__ = starknet::syscalls::library_call_syscall(
                self.class_hash,
                selector!("system_1"),
                core::array::ArrayTrait::span(@__calldata__),
            );
            let mut __dispatcher_return_data__ = starknet::SyscallResultTrait::unwrap_syscall(
                __dispatcher_return_data__,
            );
            ()
        }
        fn system_2(self: MyInterfaceLibraryDispatcher, k: felt252) -> felt252 {
            let mut __calldata__ = core::traits::Default::default();
            core::serde::Serde::<felt252>::serialize(@k, ref __calldata__);

            let mut __dispatcher_return_data__ = starknet::syscalls::library_call_syscall(
                self.class_hash,
                selector!("system_2"),
                core::array::ArrayTrait::span(@__calldata__),
            );
            let mut __dispatcher_return_data__ = starknet::SyscallResultTrait::unwrap_syscall(
                __dispatcher_return_data__,
            );
            core::option::OptionTrait::expect(
                core::serde::Serde::<felt252>::deserialize(ref __dispatcher_return_data__),
                'Returned data too short',
            )
        }
        fn system_3(self: MyInterfaceLibraryDispatcher, k: felt252, v: u32) {
            let mut __calldata__ = core::traits::Default::default();
            core::serde::Serde::<felt252>::serialize(@k, ref __calldata__);
            core::serde::Serde::<u32>::serialize(@v, ref __calldata__);

            let mut __dispatcher_return_data__ = starknet::syscalls::library_call_syscall(
                self.class_hash,
                selector!("system_3"),
                core::array::ArrayTrait::span(@__calldata__),
            );
            let mut __dispatcher_return_data__ = starknet::SyscallResultTrait::unwrap_syscall(
                __dispatcher_return_data__,
            );
            ()
        }
        fn system_4(self: MyInterfaceLibraryDispatcher, k: felt252) {
            let mut __calldata__ = core::traits::Default::default();
            core::serde::Serde::<felt252>::serialize(@k, ref __calldata__);

            let mut __dispatcher_return_data__ = starknet::syscalls::library_call_syscall(
                self.class_hash,
                selector!("system_4"),
                core::array::ArrayTrait::span(@__calldata__),
            );
            let mut __dispatcher_return_data__ = starknet::SyscallResultTrait::unwrap_syscall(
                __dispatcher_return_data__,
            );
            ()
        }
        fn system_dbg(
            self: MyInterfaceLibraryDispatcher,
            objective_ids: Option<Span<u32>>,
            game_context: Option<GameContextDetails>,
        ) {
            let mut __calldata__ = core::traits::Default::default();
            core::serde::Serde::<Option<Span<u32>>>::serialize(@objective_ids, ref __calldata__);
            core::serde::Serde::<
                Option<GameContextDetails>,
            >::serialize(@game_context, ref __calldata__);

            let mut __dispatcher_return_data__ = starknet::syscalls::library_call_syscall(
                self.class_hash,
                selector!("system_dbg"),
                core::array::ArrayTrait::span(@__calldata__),
            );
            let mut __dispatcher_return_data__ = starknet::SyscallResultTrait::unwrap_syscall(
                __dispatcher_return_data__,
            );
            ()
        }
    }

    #[doc(group: "dispatchers")]
    pub trait MyInterfaceSafeDispatcherTrait<T> {
        #[unstable(feature: "safe_dispatcher")]
        fn system_1(self: T, k: felt252, v: felt252) -> starknet::SyscallResult<()>;
        #[unstable(feature: "safe_dispatcher")]
        fn system_2(self: T, k: felt252) -> starknet::SyscallResult<felt252>;
        #[unstable(feature: "safe_dispatcher")]
        fn system_3(self: T, k: felt252, v: u32) -> starknet::SyscallResult<()>;
        #[unstable(feature: "safe_dispatcher")]
        fn system_4(self: T, k: felt252) -> starknet::SyscallResult<()>;
        #[unstable(feature: "safe_dispatcher")]
        fn system_dbg(
            self: T, objective_ids: Option<Span<u32>>, game_context: Option<GameContextDetails>,
        ) -> starknet::SyscallResult<()>;
    }

    #[doc(group: "dispatchers")]
    #[derive(Copy, Drop, starknet::Store, Serde)]
    pub struct MyInterfaceSafeLibraryDispatcher {
        pub class_hash: starknet::ClassHash,
    }

    #[doc(group: "dispatchers")]
    impl MyInterfaceSafeLibraryDispatcherImpl of MyInterfaceSafeDispatcherTrait<
        MyInterfaceSafeLibraryDispatcher,
    > {
        fn system_1(
            self: MyInterfaceSafeLibraryDispatcher, k: felt252, v: felt252,
        ) -> starknet::SyscallResult<()> {
            let mut __calldata__ = core::traits::Default::default();
            core::serde::Serde::<felt252>::serialize(@k, ref __calldata__);
            core::serde::Serde::<felt252>::serialize(@v, ref __calldata__);

            let mut __dispatcher_return_data__ = starknet::syscalls::library_call_syscall(
                self.class_hash,
                selector!("system_1"),
                core::array::ArrayTrait::span(@__calldata__),
            );
            let mut __dispatcher_return_data__ = __dispatcher_return_data__?;
            Result::Ok(())
        }
        fn system_2(
            self: MyInterfaceSafeLibraryDispatcher, k: felt252,
        ) -> starknet::SyscallResult<felt252> {
            let mut __calldata__ = core::traits::Default::default();
            core::serde::Serde::<felt252>::serialize(@k, ref __calldata__);

            let mut __dispatcher_return_data__ = starknet::syscalls::library_call_syscall(
                self.class_hash,
                selector!("system_2"),
                core::array::ArrayTrait::span(@__calldata__),
            );
            let mut __dispatcher_return_data__ = __dispatcher_return_data__?;
            Result::Ok(
                core::option::OptionTrait::expect(
                    core::serde::Serde::<felt252>::deserialize(ref __dispatcher_return_data__),
                    'Returned data too short',
                ),
            )
        }
        fn system_3(
            self: MyInterfaceSafeLibraryDispatcher, k: felt252, v: u32,
        ) -> starknet::SyscallResult<()> {
            let mut __calldata__ = core::traits::Default::default();
            core::serde::Serde::<felt252>::serialize(@k, ref __calldata__);
            core::serde::Serde::<u32>::serialize(@v, ref __calldata__);

            let mut __dispatcher_return_data__ = starknet::syscalls::library_call_syscall(
                self.class_hash,
                selector!("system_3"),
                core::array::ArrayTrait::span(@__calldata__),
            );
            let mut __dispatcher_return_data__ = __dispatcher_return_data__?;
            Result::Ok(())
        }
        fn system_4(
            self: MyInterfaceSafeLibraryDispatcher, k: felt252,
        ) -> starknet::SyscallResult<()> {
            let mut __calldata__ = core::traits::Default::default();
            core::serde::Serde::<felt252>::serialize(@k, ref __calldata__);

            let mut __dispatcher_return_data__ = starknet::syscalls::library_call_syscall(
                self.class_hash,
                selector!("system_4"),
                core::array::ArrayTrait::span(@__calldata__),
            );
            let mut __dispatcher_return_data__ = __dispatcher_return_data__?;
            Result::Ok(())
        }
        fn system_dbg(
            self: MyInterfaceSafeLibraryDispatcher,
            objective_ids: Option<Span<u32>>,
            game_context: Option<GameContextDetails>,
        ) -> starknet::SyscallResult<()> {
            let mut __calldata__ = core::traits::Default::default();
            core::serde::Serde::<Option<Span<u32>>>::serialize(@objective_ids, ref __calldata__);
            core::serde::Serde::<
                Option<GameContextDetails>,
            >::serialize(@game_context, ref __calldata__);

            let mut __dispatcher_return_data__ = starknet::syscalls::library_call_syscall(
                self.class_hash,
                selector!("system_dbg"),
                core::array::ArrayTrait::span(@__calldata__),
            );
            let mut __dispatcher_return_data__ = __dispatcher_return_data__?;
            Result::Ok(())
        }
    }


    #[doc(group: "dispatchers")]
    #[derive(Copy, Drop, starknet::Store, Serde)]
    pub struct MyInterfaceSafeDispatcher {
        pub contract_address: starknet::ContractAddress,
    }

    #[doc(group: "dispatchers")]
    impl MyInterfaceSafeDispatcherImpl of MyInterfaceSafeDispatcherTrait<
        MyInterfaceSafeDispatcher,
    > {
        fn system_1(
            self: MyInterfaceSafeDispatcher, k: felt252, v: felt252,
        ) -> starknet::SyscallResult<()> {
            let mut __calldata__ = core::traits::Default::default();
            core::serde::Serde::<felt252>::serialize(@k, ref __calldata__);
            core::serde::Serde::<felt252>::serialize(@v, ref __calldata__);

            let mut __dispatcher_return_data__ = starknet::syscalls::call_contract_syscall(
                self.contract_address,
                selector!("system_1"),
                core::array::ArrayTrait::span(@__calldata__),
            );
            let mut __dispatcher_return_data__ = __dispatcher_return_data__?;
            Result::Ok(())
        }
        fn system_2(
            self: MyInterfaceSafeDispatcher, k: felt252,
        ) -> starknet::SyscallResult<felt252> {
            let mut __calldata__ = core::traits::Default::default();
            core::serde::Serde::<felt252>::serialize(@k, ref __calldata__);

            let mut __dispatcher_return_data__ = starknet::syscalls::call_contract_syscall(
                self.contract_address,
                selector!("system_2"),
                core::array::ArrayTrait::span(@__calldata__),
            );
            let mut __dispatcher_return_data__ = __dispatcher_return_data__?;
            Result::Ok(
                core::option::OptionTrait::expect(
                    core::serde::Serde::<felt252>::deserialize(ref __dispatcher_return_data__),
                    'Returned data too short',
                ),
            )
        }
        fn system_3(
            self: MyInterfaceSafeDispatcher, k: felt252, v: u32,
        ) -> starknet::SyscallResult<()> {
            let mut __calldata__ = core::traits::Default::default();
            core::serde::Serde::<felt252>::serialize(@k, ref __calldata__);
            core::serde::Serde::<u32>::serialize(@v, ref __calldata__);

            let mut __dispatcher_return_data__ = starknet::syscalls::call_contract_syscall(
                self.contract_address,
                selector!("system_3"),
                core::array::ArrayTrait::span(@__calldata__),
            );
            let mut __dispatcher_return_data__ = __dispatcher_return_data__?;
            Result::Ok(())
        }
        fn system_4(self: MyInterfaceSafeDispatcher, k: felt252) -> starknet::SyscallResult<()> {
            let mut __calldata__ = core::traits::Default::default();
            core::serde::Serde::<felt252>::serialize(@k, ref __calldata__);

            let mut __dispatcher_return_data__ = starknet::syscalls::call_contract_syscall(
                self.contract_address,
                selector!("system_4"),
                core::array::ArrayTrait::span(@__calldata__),
            );
            let mut __dispatcher_return_data__ = __dispatcher_return_data__?;
            Result::Ok(())
        }
        fn system_dbg(
            self: MyInterfaceSafeDispatcher,
            objective_ids: Option<Span<u32>>,
            game_context: Option<GameContextDetails>,
        ) -> starknet::SyscallResult<()> {
            let mut __calldata__ = core::traits::Default::default();
            core::serde::Serde::<Option<Span<u32>>>::serialize(@objective_ids, ref __calldata__);
            core::serde::Serde::<
                Option<GameContextDetails>,
            >::serialize(@game_context, ref __calldata__);

            let mut __dispatcher_return_data__ = starknet::syscalls::call_contract_syscall(
                self.contract_address,
                selector!("system_dbg"),
                core::array::ArrayTrait::span(@__calldata__),
            );
            let mut __dispatcher_return_data__ = __dispatcher_return_data__?;
            Result::Ok(())
        }
    }
    impl MIntrospect of dojo::meta::introspect::Introspect<M> {
        #[inline(always)]
        fn size() -> Option<usize> {
            dojo::meta::introspect::Introspect::<felt252>::size()
        }
        #[inline(always)]
        fn layout() -> dojo::meta::Layout {
            dojo::meta::Layout::Struct(
                array![
                    dojo::meta::FieldLayout {
                        selector: 578691550836206188651404750433984985630363913126316857592149308417275000080,
                        layout: dojo::meta::introspect::Introspect::<felt252>::layout(),
                    },
                ]
                    .span(),
            )
        }
        #[inline(always)]
        fn ty() -> dojo::meta::introspect::Ty {
            dojo::meta::introspect::Ty::Struct(
                dojo::meta::introspect::Struct {
                    name: 'M',
                    attrs: array![].span(),
                    children: array![
                        dojo::meta::introspect::Member {
                            name: 'k',
                            attrs: array!['key'].span(),
                            ty: dojo::meta::introspect::Introspect::<felt252>::ty(),
                        },
                        dojo::meta::introspect::Member {
                            name: 'v',
                            attrs: array![].span(),
                            ty: dojo::meta::introspect::Introspect::<felt252>::ty(),
                        },
                    ]
                        .span(),
                },
            )
        }
    }
    impl MDojoStore of dojo::storage::DojoStore<M> {
        fn dojo_serialize(self: @M, ref serialized: Array<felt252>) {
            dojo::storage::DojoStore::dojo_serialize(self.k, ref serialized);
            dojo::storage::DojoStore::dojo_serialize(self.v, ref serialized);
        }
        fn dojo_deserialize(ref values: Span<felt252>) -> Option<M> {
            let k = dojo::storage::DojoStore::<felt252>::dojo_deserialize(ref values)?;
            let v = dojo::storage::DojoStore::<felt252>::dojo_deserialize(ref values)?;

            Option::Some(M { k, v })
        }
    }
    impl MSerde<> of core::serde::Serde<M> {
        fn serialize(self: @M, ref output: core::array::Array<felt252>) {
            core::serde::Serde::<felt252>::serialize(self.k, ref output);
            core::serde::Serde::<felt252>::serialize(self.v, ref output)
        }
        fn deserialize(ref serialized: core::array::Span<felt252>) -> core::option::Option<M> {
            let k = core::internal::InferDestruct::<
                felt252,
            > { value: core::serde::Serde::<felt252>::deserialize(ref serialized)? };
            let v = core::internal::InferDestruct::<
                felt252,
            > { value: core::serde::Serde::<felt252>::deserialize(ref serialized)? };
            core::option::Option::Some(M { k: k.value, v: v.value })
        }
    }
    impl MDrop<> of core::traits::Drop<M>;
    impl MValueIntrospect of dojo::meta::introspect::Introspect<MValue> {
        #[inline(always)]
        fn size() -> Option<usize> {
            dojo::meta::introspect::Introspect::<felt252>::size()
        }
        #[inline(always)]
        fn layout() -> dojo::meta::Layout {
            dojo::meta::Layout::Struct(
                array![
                    dojo::meta::FieldLayout {
                        selector: 578691550836206188651404750433984985630363913126316857592149308417275000080,
                        layout: dojo::meta::introspect::Introspect::<felt252>::layout(),
                    },
                ]
                    .span(),
            )
        }
        #[inline(always)]
        fn ty() -> dojo::meta::introspect::Ty {
            dojo::meta::introspect::Ty::Struct(
                dojo::meta::introspect::Struct {
                    name: 'MValue',
                    attrs: array![].span(),
                    children: array![
                        dojo::meta::introspect::Member {
                            name: 'v',
                            attrs: array![].span(),
                            ty: dojo::meta::introspect::Introspect::<felt252>::ty(),
                        },
                    ]
                        .span(),
                },
            )
        }
    }
    impl MValueDojoStore of dojo::storage::DojoStore<MValue> {
        fn dojo_serialize(self: @MValue, ref serialized: Array<felt252>) {
            dojo::storage::DojoStore::dojo_serialize(self.v, ref serialized);
        }
        fn dojo_deserialize(ref values: Span<felt252>) -> Option<MValue> {
            let v = dojo::storage::DojoStore::<felt252>::dojo_deserialize(ref values)?;

            Option::Some(MValue { v })
        }
    }
    impl MValueSerde<> of core::serde::Serde<MValue> {
        fn serialize(self: @MValue, ref output: core::array::Array<felt252>) {
            core::serde::Serde::<felt252>::serialize(self.v, ref output)
        }
        fn deserialize(ref serialized: core::array::Span<felt252>) -> core::option::Option<MValue> {
            let v = core::internal::InferDestruct::<
                felt252,
            > { value: core::serde::Serde::<felt252>::deserialize(ref serialized)? };
            core::option::Option::Some(MValue { v: v.value })
        }
    }
    impl MValueDrop<> of core::traits::Drop<MValue>;
    impl EIntrospect of dojo::meta::introspect::Introspect<E> {
        #[inline(always)]
        fn size() -> Option<usize> {
            dojo::meta::introspect::Introspect::<u32>::size()
        }
        #[inline(always)]
        fn layout() -> dojo::meta::Layout {
            dojo::meta::Layout::Struct(
                array![
                    dojo::meta::FieldLayout {
                        selector: 578691550836206188651404750433984985630363913126316857592149308417275000080,
                        layout: dojo::meta::introspect::Introspect::<u32>::layout(),
                    },
                ]
                    .span(),
            )
        }
        #[inline(always)]
        fn ty() -> dojo::meta::introspect::Ty {
            dojo::meta::introspect::Ty::Struct(
                dojo::meta::introspect::Struct {
                    name: 'E',
                    attrs: array![].span(),
                    children: array![
                        dojo::meta::introspect::Member {
                            name: 'k',
                            attrs: array!['key'].span(),
                            ty: dojo::meta::introspect::Introspect::<felt252>::ty(),
                        },
                        dojo::meta::introspect::Member {
                            name: 'v',
                            attrs: array![].span(),
                            ty: dojo::meta::introspect::Introspect::<u32>::ty(),
                        },
                    ]
                        .span(),
                },
            )
        }
    }
    impl ESerde<> of core::serde::Serde<E> {
        fn serialize(self: @E, ref output: core::array::Array<felt252>) {
            core::serde::Serde::<felt252>::serialize(self.k, ref output);
            core::serde::Serde::<u32>::serialize(self.v, ref output)
        }
        fn deserialize(ref serialized: core::array::Span<felt252>) -> core::option::Option<E> {
            let k = core::internal::InferDestruct::<
                felt252,
            > { value: core::serde::Serde::<felt252>::deserialize(ref serialized)? };
            let v = core::internal::InferDestruct::<
                u32,
            > { value: core::serde::Serde::<u32>::deserialize(ref serialized)? };
            core::option::Option::Some(E { k: k.value, v: v.value })
        }
    }
    impl EDrop<> of core::traits::Drop<E>;
    impl EValueIntrospect of dojo::meta::introspect::Introspect<EValue> {
        #[inline(always)]
        fn size() -> Option<usize> {
            dojo::meta::introspect::Introspect::<u32>::size()
        }
        #[inline(always)]
        fn layout() -> dojo::meta::Layout {
            dojo::meta::Layout::Struct(
                array![
                    dojo::meta::FieldLayout {
                        selector: 578691550836206188651404750433984985630363913126316857592149308417275000080,
                        layout: dojo::meta::introspect::Introspect::<u32>::layout(),
                    },
                ]
                    .span(),
            )
        }
        #[inline(always)]
        fn ty() -> dojo::meta::introspect::Ty {
            dojo::meta::introspect::Ty::Struct(
                dojo::meta::introspect::Struct {
                    name: 'EValue',
                    attrs: array![].span(),
                    children: array![
                        dojo::meta::introspect::Member {
                            name: 'v',
                            attrs: array![].span(),
                            ty: dojo::meta::introspect::Introspect::<u32>::ty(),
                        },
                    ]
                        .span(),
                },
            )
        }
    }
    impl EValueSerde<> of core::serde::Serde<EValue> {
        fn serialize(self: @EValue, ref output: core::array::Array<felt252>) {
            core::serde::Serde::<u32>::serialize(self.v, ref output)
        }
        fn deserialize(ref serialized: core::array::Span<felt252>) -> core::option::Option<EValue> {
            let v = core::internal::InferDestruct::<
                u32,
            > { value: core::serde::Serde::<u32>::deserialize(ref serialized)? };
            core::option::Option::Some(EValue { v: v.value })
        }
    }
    impl EValueDrop<> of core::traits::Drop<EValue>;
    impl EHIntrospect of dojo::meta::introspect::Introspect<EH> {
        #[inline(always)]
        fn size() -> Option<usize> {
            dojo::meta::introspect::Introspect::<u32>::size()
        }
        #[inline(always)]
        fn layout() -> dojo::meta::Layout {
            dojo::meta::Layout::Struct(
                array![
                    dojo::meta::FieldLayout {
                        selector: 578691550836206188651404750433984985630363913126316857592149308417275000080,
                        layout: dojo::meta::introspect::Introspect::<u32>::layout(),
                    },
                ]
                    .span(),
            )
        }
        #[inline(always)]
        fn ty() -> dojo::meta::introspect::Ty {
            dojo::meta::introspect::Ty::Struct(
                dojo::meta::introspect::Struct {
                    name: 'EH',
                    attrs: array![].span(),
                    children: array![
                        dojo::meta::introspect::Member {
                            name: 'k',
                            attrs: array!['key'].span(),
                            ty: dojo::meta::introspect::Introspect::<felt252>::ty(),
                        },
                        dojo::meta::introspect::Member {
                            name: 'v',
                            attrs: array![].span(),
                            ty: dojo::meta::introspect::Introspect::<u32>::ty(),
                        },
                    ]
                        .span(),
                },
            )
        }
    }
    impl EHSerde<> of core::serde::Serde<EH> {
        fn serialize(self: @EH, ref output: core::array::Array<felt252>) {
            core::serde::Serde::<felt252>::serialize(self.k, ref output);
            core::serde::Serde::<u32>::serialize(self.v, ref output)
        }
        fn deserialize(ref serialized: core::array::Span<felt252>) -> core::option::Option<EH> {
            let k = core::internal::InferDestruct::<
                felt252,
            > { value: core::serde::Serde::<felt252>::deserialize(ref serialized)? };
            let v = core::internal::InferDestruct::<
                u32,
            > { value: core::serde::Serde::<u32>::deserialize(ref serialized)? };
            core::option::Option::Some(EH { k: k.value, v: v.value })
        }
    }
    impl EHDrop<> of core::traits::Drop<EH>;
    impl EHValueIntrospect of dojo::meta::introspect::Introspect<EHValue> {
        #[inline(always)]
        fn size() -> Option<usize> {
            dojo::meta::introspect::Introspect::<u32>::size()
        }
        #[inline(always)]
        fn layout() -> dojo::meta::Layout {
            dojo::meta::Layout::Struct(
                array![
                    dojo::meta::FieldLayout {
                        selector: 578691550836206188651404750433984985630363913126316857592149308417275000080,
                        layout: dojo::meta::introspect::Introspect::<u32>::layout(),
                    },
                ]
                    .span(),
            )
        }
        #[inline(always)]
        fn ty() -> dojo::meta::introspect::Ty {
            dojo::meta::introspect::Ty::Struct(
                dojo::meta::introspect::Struct {
                    name: 'EHValue',
                    attrs: array![].span(),
                    children: array![
                        dojo::meta::introspect::Member {
                            name: 'v',
                            attrs: array![].span(),
                            ty: dojo::meta::introspect::Introspect::<u32>::ty(),
                        },
                    ]
                        .span(),
                },
            )
        }
    }
    impl EHValueSerde<> of core::serde::Serde<EHValue> {
        fn serialize(self: @EHValue, ref output: core::array::Array<felt252>) {
            core::serde::Serde::<u32>::serialize(self.v, ref output)
        }
        fn deserialize(
            ref serialized: core::array::Span<felt252>,
        ) -> core::option::Option<EHValue> {
            let v = core::internal::InferDestruct::<
                u32,
            > { value: core::serde::Serde::<u32>::deserialize(ref serialized)? };
            core::option::Option::Some(EHValue { v: v.value })
        }
    }
    impl EHValueDrop<> of core::traits::Drop<EHValue>;
    #[doc(group: "dispatchers")]
    impl MyInterfaceDispatcherCopy<> of core::traits::Copy<MyInterfaceDispatcher>;
    #[doc(group: "dispatchers")]
    impl MyInterfaceDispatcherDrop<> of core::traits::Drop<MyInterfaceDispatcher>;
    #[doc(group: "dispatchers")]
    impl MyInterfaceDispatcherSerde<> of core::serde::Serde<MyInterfaceDispatcher> {
        fn serialize(self: @MyInterfaceDispatcher, ref output: core::array::Array<felt252>) {
            core::serde::Serde::<
                starknet::ContractAddress,
            >::serialize(self.contract_address, ref output)
        }
        fn deserialize(
            ref serialized: core::array::Span<felt252>,
        ) -> core::option::Option<MyInterfaceDispatcher> {
            let contract_address = core::internal::InferDestruct::<
                starknet::ContractAddress,
            > {
                value: core::serde::Serde::<
                    starknet::ContractAddress,
                >::deserialize(ref serialized)?,
            };
            core::option::Option::Some(
                MyInterfaceDispatcher { contract_address: contract_address.value },
            )
        }
    }
    impl MyInterfaceDispatcherStore<> of starknet::Store<MyInterfaceDispatcher> {
        fn read(
            address_domain: u32, base: starknet::storage_access::StorageBaseAddress,
        ) -> starknet::SyscallResult<MyInterfaceDispatcher> {
            let __store_derive_address_domain__ = address_domain;
            let __store_derive_base__ = base;
            let contract_address = core::internal::InferDestruct::<
                starknet::ContractAddress,
            > {
                value: starknet::Store::<
                    starknet::ContractAddress,
                >::read(__store_derive_address_domain__, __store_derive_base__)?,
            };
            starknet::SyscallResult::Ok(
                MyInterfaceDispatcher { contract_address: contract_address.value },
            )
        }
        fn write(
            address_domain: u32,
            base: starknet::storage_access::StorageBaseAddress,
            value: MyInterfaceDispatcher,
        ) -> starknet::SyscallResult<()> {
            let __store_derive_address_domain__ = address_domain;
            let __store_derive_base__ = base;
            let MyInterfaceDispatcher { contract_address } = value;
            let contract_address = core::internal::InferDestruct::<
                starknet::ContractAddress,
            > { value: contract_address };
            starknet::Store::<
                starknet::ContractAddress,
            >::write(
                __store_derive_address_domain__, __store_derive_base__, contract_address.value,
            )?;
            starknet::SyscallResult::Ok(())
        }
        fn read_at_offset(
            address_domain: u32, base: starknet::storage_access::StorageBaseAddress, offset: u8,
        ) -> starknet::SyscallResult<MyInterfaceDispatcher> {
            let __store_derive_address_domain__ = address_domain;
            let __store_derive_base__ = base;
            let __store_derive_offset__ = offset;
            let contract_address = core::internal::InferDestruct::<
                starknet::ContractAddress,
            > {
                value: starknet::Store::<
                    starknet::ContractAddress,
                >::read_at_offset(
                    __store_derive_address_domain__, __store_derive_base__, __store_derive_offset__,
                )?,
            };
            starknet::SyscallResult::Ok(
                MyInterfaceDispatcher { contract_address: contract_address.value },
            )
        }
        #[inline(always)]
        fn write_at_offset(
            address_domain: u32,
            base: starknet::storage_access::StorageBaseAddress,
            offset: u8,
            value: MyInterfaceDispatcher,
        ) -> starknet::SyscallResult<()> {
            let __store_derive_address_domain__ = address_domain;
            let __store_derive_base__ = base;
            let __store_derive_offset__ = offset;
            let MyInterfaceDispatcher { contract_address } = value;
            let contract_address = core::internal::InferDestruct::<
                starknet::ContractAddress,
            > { value: contract_address };
            starknet::Store::<
                starknet::ContractAddress,
            >::write_at_offset(
                __store_derive_address_domain__,
                __store_derive_base__,
                __store_derive_offset__,
                contract_address.value,
            )?;
            starknet::SyscallResult::Ok(())
        }
        #[inline(always)]
        fn size() -> u8 {
            starknet::Store::<starknet::ContractAddress>::size()
        }
    }

    #[derive(Drop, Copy)]
    #[doc(hidden)]
    pub struct MyInterfaceDispatcherSubPointers {
        pub contract_address: starknet::storage::StoragePointer<starknet::ContractAddress>,
    }
    #[doc(hidden)]
    impl MyInterfaceDispatcherSubPointersImpl of starknet::storage::SubPointers<
        MyInterfaceDispatcher,
    > {
        type SubPointersType = MyInterfaceDispatcherSubPointers;
        fn sub_pointers(
            self: starknet::storage::StoragePointer<MyInterfaceDispatcher>,
        ) -> MyInterfaceDispatcherSubPointers {
            let base_address = self.__storage_pointer_address__;
            let mut current_offset = self.__storage_pointer_offset__;
            let __contract_address_value__ = starknet::storage::StoragePointer {
                __storage_pointer_address__: base_address,
                __storage_pointer_offset__: current_offset,
            };
            MyInterfaceDispatcherSubPointers { contract_address: __contract_address_value__ }
        }
    }
    #[derive(Drop, Copy)]
    #[doc(hidden)]
    pub struct MyInterfaceDispatcherSubPointersMut {
        pub contract_address: starknet::storage::StoragePointer<
            starknet::storage::Mutable<starknet::ContractAddress>,
        >,
    }
    #[doc(hidden)]
    impl MyInterfaceDispatcherSubPointersMutImpl of starknet::storage::SubPointersMut<
        MyInterfaceDispatcher,
    > {
        type SubPointersType = MyInterfaceDispatcherSubPointersMut;
        fn sub_pointers_mut(
            self: starknet::storage::StoragePointer<
                starknet::storage::Mutable<MyInterfaceDispatcher>,
            >,
        ) -> MyInterfaceDispatcherSubPointersMut {
            let base_address = self.__storage_pointer_address__;
            let mut current_offset = self.__storage_pointer_offset__;
            let __contract_address_value__ = starknet::storage::StoragePointer {
                __storage_pointer_address__: base_address,
                __storage_pointer_offset__: current_offset,
            };
            MyInterfaceDispatcherSubPointersMut { contract_address: __contract_address_value__ }
        }
    }
    #[doc(group: "dispatchers")]
    impl MyInterfaceLibraryDispatcherCopy<> of core::traits::Copy<MyInterfaceLibraryDispatcher>;
    #[doc(group: "dispatchers")]
    impl MyInterfaceLibraryDispatcherDrop<> of core::traits::Drop<MyInterfaceLibraryDispatcher>;
    #[doc(group: "dispatchers")]
    impl MyInterfaceLibraryDispatcherSerde<> of core::serde::Serde<MyInterfaceLibraryDispatcher> {
        fn serialize(self: @MyInterfaceLibraryDispatcher, ref output: core::array::Array<felt252>) {
            core::serde::Serde::<starknet::ClassHash>::serialize(self.class_hash, ref output)
        }
        fn deserialize(
            ref serialized: core::array::Span<felt252>,
        ) -> core::option::Option<MyInterfaceLibraryDispatcher> {
            let class_hash = core::internal::InferDestruct::<
                starknet::ClassHash,
            > { value: core::serde::Serde::<starknet::ClassHash>::deserialize(ref serialized)? };
            core::option::Option::Some(
                MyInterfaceLibraryDispatcher { class_hash: class_hash.value },
            )
        }
    }
    impl MyInterfaceLibraryDispatcherStore<> of starknet::Store<MyInterfaceLibraryDispatcher> {
        fn read(
            address_domain: u32, base: starknet::storage_access::StorageBaseAddress,
        ) -> starknet::SyscallResult<MyInterfaceLibraryDispatcher> {
            let __store_derive_address_domain__ = address_domain;
            let __store_derive_base__ = base;
            let class_hash = core::internal::InferDestruct::<
                starknet::ClassHash,
            > {
                value: starknet::Store::<
                    starknet::ClassHash,
                >::read(__store_derive_address_domain__, __store_derive_base__)?,
            };
            starknet::SyscallResult::Ok(
                MyInterfaceLibraryDispatcher { class_hash: class_hash.value },
            )
        }
        fn write(
            address_domain: u32,
            base: starknet::storage_access::StorageBaseAddress,
            value: MyInterfaceLibraryDispatcher,
        ) -> starknet::SyscallResult<()> {
            let __store_derive_address_domain__ = address_domain;
            let __store_derive_base__ = base;
            let MyInterfaceLibraryDispatcher { class_hash } = value;
            let class_hash = core::internal::InferDestruct::<
                starknet::ClassHash,
            > { value: class_hash };
            starknet::Store::<
                starknet::ClassHash,
            >::write(__store_derive_address_domain__, __store_derive_base__, class_hash.value)?;
            starknet::SyscallResult::Ok(())
        }
        fn read_at_offset(
            address_domain: u32, base: starknet::storage_access::StorageBaseAddress, offset: u8,
        ) -> starknet::SyscallResult<MyInterfaceLibraryDispatcher> {
            let __store_derive_address_domain__ = address_domain;
            let __store_derive_base__ = base;
            let __store_derive_offset__ = offset;
            let class_hash = core::internal::InferDestruct::<
                starknet::ClassHash,
            > {
                value: starknet::Store::<
                    starknet::ClassHash,
                >::read_at_offset(
                    __store_derive_address_domain__, __store_derive_base__, __store_derive_offset__,
                )?,
            };
            starknet::SyscallResult::Ok(
                MyInterfaceLibraryDispatcher { class_hash: class_hash.value },
            )
        }
        #[inline(always)]
        fn write_at_offset(
            address_domain: u32,
            base: starknet::storage_access::StorageBaseAddress,
            offset: u8,
            value: MyInterfaceLibraryDispatcher,
        ) -> starknet::SyscallResult<()> {
            let __store_derive_address_domain__ = address_domain;
            let __store_derive_base__ = base;
            let __store_derive_offset__ = offset;
            let MyInterfaceLibraryDispatcher { class_hash } = value;
            let class_hash = core::internal::InferDestruct::<
                starknet::ClassHash,
            > { value: class_hash };
            starknet::Store::<
                starknet::ClassHash,
            >::write_at_offset(
                __store_derive_address_domain__,
                __store_derive_base__,
                __store_derive_offset__,
                class_hash.value,
            )?;
            starknet::SyscallResult::Ok(())
        }
        #[inline(always)]
        fn size() -> u8 {
            starknet::Store::<starknet::ClassHash>::size()
        }
    }

    #[derive(Drop, Copy)]
    #[doc(hidden)]
    pub struct MyInterfaceLibraryDispatcherSubPointers {
        pub class_hash: starknet::storage::StoragePointer<starknet::ClassHash>,
    }
    #[doc(hidden)]
    impl MyInterfaceLibraryDispatcherSubPointersImpl of starknet::storage::SubPointers<
        MyInterfaceLibraryDispatcher,
    > {
        type SubPointersType = MyInterfaceLibraryDispatcherSubPointers;
        fn sub_pointers(
            self: starknet::storage::StoragePointer<MyInterfaceLibraryDispatcher>,
        ) -> MyInterfaceLibraryDispatcherSubPointers {
            let base_address = self.__storage_pointer_address__;
            let mut current_offset = self.__storage_pointer_offset__;
            let __class_hash_value__ = starknet::storage::StoragePointer {
                __storage_pointer_address__: base_address,
                __storage_pointer_offset__: current_offset,
            };
            MyInterfaceLibraryDispatcherSubPointers { class_hash: __class_hash_value__ }
        }
    }
    #[derive(Drop, Copy)]
    #[doc(hidden)]
    pub struct MyInterfaceLibraryDispatcherSubPointersMut {
        pub class_hash: starknet::storage::StoragePointer<
            starknet::storage::Mutable<starknet::ClassHash>,
        >,
    }
    #[doc(hidden)]
    impl MyInterfaceLibraryDispatcherSubPointersMutImpl of starknet::storage::SubPointersMut<
        MyInterfaceLibraryDispatcher,
    > {
        type SubPointersType = MyInterfaceLibraryDispatcherSubPointersMut;
        fn sub_pointers_mut(
            self: starknet::storage::StoragePointer<
                starknet::storage::Mutable<MyInterfaceLibraryDispatcher>,
            >,
        ) -> MyInterfaceLibraryDispatcherSubPointersMut {
            let base_address = self.__storage_pointer_address__;
            let mut current_offset = self.__storage_pointer_offset__;
            let __class_hash_value__ = starknet::storage::StoragePointer {
                __storage_pointer_address__: base_address,
                __storage_pointer_offset__: current_offset,
            };
            MyInterfaceLibraryDispatcherSubPointersMut { class_hash: __class_hash_value__ }
        }
    }
    #[doc(group: "dispatchers")]
    impl MyInterfaceSafeLibraryDispatcherCopy<> of core::traits::Copy<
        MyInterfaceSafeLibraryDispatcher,
    >;
    #[doc(group: "dispatchers")]
    impl MyInterfaceSafeLibraryDispatcherDrop<> of core::traits::Drop<
        MyInterfaceSafeLibraryDispatcher,
    >;
    #[doc(group: "dispatchers")]
    impl MyInterfaceSafeLibraryDispatcherSerde<> of core::serde::Serde<
        MyInterfaceSafeLibraryDispatcher,
    > {
        fn serialize(
            self: @MyInterfaceSafeLibraryDispatcher, ref output: core::array::Array<felt252>,
        ) {
            core::serde::Serde::<starknet::ClassHash>::serialize(self.class_hash, ref output)
        }
        fn deserialize(
            ref serialized: core::array::Span<felt252>,
        ) -> core::option::Option<MyInterfaceSafeLibraryDispatcher> {
            let class_hash = core::internal::InferDestruct::<
                starknet::ClassHash,
            > { value: core::serde::Serde::<starknet::ClassHash>::deserialize(ref serialized)? };
            core::option::Option::Some(
                MyInterfaceSafeLibraryDispatcher { class_hash: class_hash.value },
            )
        }
    }
    impl MyInterfaceSafeLibraryDispatcherStore<> of starknet::Store<
        MyInterfaceSafeLibraryDispatcher,
    > {
        fn read(
            address_domain: u32, base: starknet::storage_access::StorageBaseAddress,
        ) -> starknet::SyscallResult<MyInterfaceSafeLibraryDispatcher> {
            let __store_derive_address_domain__ = address_domain;
            let __store_derive_base__ = base;
            let class_hash = core::internal::InferDestruct::<
                starknet::ClassHash,
            > {
                value: starknet::Store::<
                    starknet::ClassHash,
                >::read(__store_derive_address_domain__, __store_derive_base__)?,
            };
            starknet::SyscallResult::Ok(
                MyInterfaceSafeLibraryDispatcher { class_hash: class_hash.value },
            )
        }
        fn write(
            address_domain: u32,
            base: starknet::storage_access::StorageBaseAddress,
            value: MyInterfaceSafeLibraryDispatcher,
        ) -> starknet::SyscallResult<()> {
            let __store_derive_address_domain__ = address_domain;
            let __store_derive_base__ = base;
            let MyInterfaceSafeLibraryDispatcher { class_hash } = value;
            let class_hash = core::internal::InferDestruct::<
                starknet::ClassHash,
            > { value: class_hash };
            starknet::Store::<
                starknet::ClassHash,
            >::write(__store_derive_address_domain__, __store_derive_base__, class_hash.value)?;
            starknet::SyscallResult::Ok(())
        }
        fn read_at_offset(
            address_domain: u32, base: starknet::storage_access::StorageBaseAddress, offset: u8,
        ) -> starknet::SyscallResult<MyInterfaceSafeLibraryDispatcher> {
            let __store_derive_address_domain__ = address_domain;
            let __store_derive_base__ = base;
            let __store_derive_offset__ = offset;
            let class_hash = core::internal::InferDestruct::<
                starknet::ClassHash,
            > {
                value: starknet::Store::<
                    starknet::ClassHash,
                >::read_at_offset(
                    __store_derive_address_domain__, __store_derive_base__, __store_derive_offset__,
                )?,
            };
            starknet::SyscallResult::Ok(
                MyInterfaceSafeLibraryDispatcher { class_hash: class_hash.value },
            )
        }
        #[inline(always)]
        fn write_at_offset(
            address_domain: u32,
            base: starknet::storage_access::StorageBaseAddress,
            offset: u8,
            value: MyInterfaceSafeLibraryDispatcher,
        ) -> starknet::SyscallResult<()> {
            let __store_derive_address_domain__ = address_domain;
            let __store_derive_base__ = base;
            let __store_derive_offset__ = offset;
            let MyInterfaceSafeLibraryDispatcher { class_hash } = value;
            let class_hash = core::internal::InferDestruct::<
                starknet::ClassHash,
            > { value: class_hash };
            starknet::Store::<
                starknet::ClassHash,
            >::write_at_offset(
                __store_derive_address_domain__,
                __store_derive_base__,
                __store_derive_offset__,
                class_hash.value,
            )?;
            starknet::SyscallResult::Ok(())
        }
        #[inline(always)]
        fn size() -> u8 {
            starknet::Store::<starknet::ClassHash>::size()
        }
    }

    #[derive(Drop, Copy)]
    #[doc(hidden)]
    pub struct MyInterfaceSafeLibraryDispatcherSubPointers {
        pub class_hash: starknet::storage::StoragePointer<starknet::ClassHash>,
    }
    #[doc(hidden)]
    impl MyInterfaceSafeLibraryDispatcherSubPointersImpl of starknet::storage::SubPointers<
        MyInterfaceSafeLibraryDispatcher,
    > {
        type SubPointersType = MyInterfaceSafeLibraryDispatcherSubPointers;
        fn sub_pointers(
            self: starknet::storage::StoragePointer<MyInterfaceSafeLibraryDispatcher>,
        ) -> MyInterfaceSafeLibraryDispatcherSubPointers {
            let base_address = self.__storage_pointer_address__;
            let mut current_offset = self.__storage_pointer_offset__;
            let __class_hash_value__ = starknet::storage::StoragePointer {
                __storage_pointer_address__: base_address,
                __storage_pointer_offset__: current_offset,
            };
            MyInterfaceSafeLibraryDispatcherSubPointers { class_hash: __class_hash_value__ }
        }
    }
    #[derive(Drop, Copy)]
    #[doc(hidden)]
    pub struct MyInterfaceSafeLibraryDispatcherSubPointersMut {
        pub class_hash: starknet::storage::StoragePointer<
            starknet::storage::Mutable<starknet::ClassHash>,
        >,
    }
    #[doc(hidden)]
    impl MyInterfaceSafeLibraryDispatcherSubPointersMutImpl of starknet::storage::SubPointersMut<
        MyInterfaceSafeLibraryDispatcher,
    > {
        type SubPointersType = MyInterfaceSafeLibraryDispatcherSubPointersMut;
        fn sub_pointers_mut(
            self: starknet::storage::StoragePointer<
                starknet::storage::Mutable<MyInterfaceSafeLibraryDispatcher>,
            >,
        ) -> MyInterfaceSafeLibraryDispatcherSubPointersMut {
            let base_address = self.__storage_pointer_address__;
            let mut current_offset = self.__storage_pointer_offset__;
            let __class_hash_value__ = starknet::storage::StoragePointer {
                __storage_pointer_address__: base_address,
                __storage_pointer_offset__: current_offset,
            };
            MyInterfaceSafeLibraryDispatcherSubPointersMut { class_hash: __class_hash_value__ }
        }
    }
    #[doc(group: "dispatchers")]
    impl MyInterfaceSafeDispatcherCopy<> of core::traits::Copy<MyInterfaceSafeDispatcher>;
    #[doc(group: "dispatchers")]
    impl MyInterfaceSafeDispatcherDrop<> of core::traits::Drop<MyInterfaceSafeDispatcher>;
    #[doc(group: "dispatchers")]
    impl MyInterfaceSafeDispatcherSerde<> of core::serde::Serde<MyInterfaceSafeDispatcher> {
        fn serialize(self: @MyInterfaceSafeDispatcher, ref output: core::array::Array<felt252>) {
            core::serde::Serde::<
                starknet::ContractAddress,
            >::serialize(self.contract_address, ref output)
        }
        fn deserialize(
            ref serialized: core::array::Span<felt252>,
        ) -> core::option::Option<MyInterfaceSafeDispatcher> {
            let contract_address = core::internal::InferDestruct::<
                starknet::ContractAddress,
            > {
                value: core::serde::Serde::<
                    starknet::ContractAddress,
                >::deserialize(ref serialized)?,
            };
            core::option::Option::Some(
                MyInterfaceSafeDispatcher { contract_address: contract_address.value },
            )
        }
    }
    impl MyInterfaceSafeDispatcherStore<> of starknet::Store<MyInterfaceSafeDispatcher> {
        fn read(
            address_domain: u32, base: starknet::storage_access::StorageBaseAddress,
        ) -> starknet::SyscallResult<MyInterfaceSafeDispatcher> {
            let __store_derive_address_domain__ = address_domain;
            let __store_derive_base__ = base;
            let contract_address = core::internal::InferDestruct::<
                starknet::ContractAddress,
            > {
                value: starknet::Store::<
                    starknet::ContractAddress,
                >::read(__store_derive_address_domain__, __store_derive_base__)?,
            };
            starknet::SyscallResult::Ok(
                MyInterfaceSafeDispatcher { contract_address: contract_address.value },
            )
        }
        fn write(
            address_domain: u32,
            base: starknet::storage_access::StorageBaseAddress,
            value: MyInterfaceSafeDispatcher,
        ) -> starknet::SyscallResult<()> {
            let __store_derive_address_domain__ = address_domain;
            let __store_derive_base__ = base;
            let MyInterfaceSafeDispatcher { contract_address } = value;
            let contract_address = core::internal::InferDestruct::<
                starknet::ContractAddress,
            > { value: contract_address };
            starknet::Store::<
                starknet::ContractAddress,
            >::write(
                __store_derive_address_domain__, __store_derive_base__, contract_address.value,
            )?;
            starknet::SyscallResult::Ok(())
        }
        fn read_at_offset(
            address_domain: u32, base: starknet::storage_access::StorageBaseAddress, offset: u8,
        ) -> starknet::SyscallResult<MyInterfaceSafeDispatcher> {
            let __store_derive_address_domain__ = address_domain;
            let __store_derive_base__ = base;
            let __store_derive_offset__ = offset;
            let contract_address = core::internal::InferDestruct::<
                starknet::ContractAddress,
            > {
                value: starknet::Store::<
                    starknet::ContractAddress,
                >::read_at_offset(
                    __store_derive_address_domain__, __store_derive_base__, __store_derive_offset__,
                )?,
            };
            starknet::SyscallResult::Ok(
                MyInterfaceSafeDispatcher { contract_address: contract_address.value },
            )
        }
        #[inline(always)]
        fn write_at_offset(
            address_domain: u32,
            base: starknet::storage_access::StorageBaseAddress,
            offset: u8,
            value: MyInterfaceSafeDispatcher,
        ) -> starknet::SyscallResult<()> {
            let __store_derive_address_domain__ = address_domain;
            let __store_derive_base__ = base;
            let __store_derive_offset__ = offset;
            let MyInterfaceSafeDispatcher { contract_address } = value;
            let contract_address = core::internal::InferDestruct::<
                starknet::ContractAddress,
            > { value: contract_address };
            starknet::Store::<
                starknet::ContractAddress,
            >::write_at_offset(
                __store_derive_address_domain__,
                __store_derive_base__,
                __store_derive_offset__,
                contract_address.value,
            )?;
            starknet::SyscallResult::Ok(())
        }
        #[inline(always)]
        fn size() -> u8 {
            starknet::Store::<starknet::ContractAddress>::size()
        }
    }

    #[derive(Drop, Copy)]
    #[doc(hidden)]
    pub struct MyInterfaceSafeDispatcherSubPointers {
        pub contract_address: starknet::storage::StoragePointer<starknet::ContractAddress>,
    }
    #[doc(hidden)]
    impl MyInterfaceSafeDispatcherSubPointersImpl of starknet::storage::SubPointers<
        MyInterfaceSafeDispatcher,
    > {
        type SubPointersType = MyInterfaceSafeDispatcherSubPointers;
        fn sub_pointers(
            self: starknet::storage::StoragePointer<MyInterfaceSafeDispatcher>,
        ) -> MyInterfaceSafeDispatcherSubPointers {
            let base_address = self.__storage_pointer_address__;
            let mut current_offset = self.__storage_pointer_offset__;
            let __contract_address_value__ = starknet::storage::StoragePointer {
                __storage_pointer_address__: base_address,
                __storage_pointer_offset__: current_offset,
            };
            MyInterfaceSafeDispatcherSubPointers { contract_address: __contract_address_value__ }
        }
    }
    #[derive(Drop, Copy)]
    #[doc(hidden)]
    pub struct MyInterfaceSafeDispatcherSubPointersMut {
        pub contract_address: starknet::storage::StoragePointer<
            starknet::storage::Mutable<starknet::ContractAddress>,
        >,
    }
    #[doc(hidden)]
    impl MyInterfaceSafeDispatcherSubPointersMutImpl of starknet::storage::SubPointersMut<
        MyInterfaceSafeDispatcher,
    > {
        type SubPointersType = MyInterfaceSafeDispatcherSubPointersMut;
        fn sub_pointers_mut(
            self: starknet::storage::StoragePointer<
                starknet::storage::Mutable<MyInterfaceSafeDispatcher>,
            >,
        ) -> MyInterfaceSafeDispatcherSubPointersMut {
            let base_address = self.__storage_pointer_address__;
            let mut current_offset = self.__storage_pointer_offset__;
            let __contract_address_value__ = starknet::storage::StoragePointer {
                __storage_pointer_address__: base_address,
                __storage_pointer_offset__: current_offset,
            };
            MyInterfaceSafeDispatcherSubPointersMut { contract_address: __contract_address_value__ }
        }
    }
    #[doc(hidden)]
    impl MyInterfaceDispatcherSubPointersDrop<> of core::traits::Drop<
        MyInterfaceDispatcherSubPointers,
    >;
    #[doc(hidden)]
    impl MyInterfaceDispatcherSubPointersCopy<> of core::traits::Copy<
        MyInterfaceDispatcherSubPointers,
    >;
    #[doc(hidden)]
    impl MyInterfaceDispatcherSubPointersMutDrop<> of core::traits::Drop<
        MyInterfaceDispatcherSubPointersMut,
    >;
    #[doc(hidden)]
    impl MyInterfaceDispatcherSubPointersMutCopy<> of core::traits::Copy<
        MyInterfaceDispatcherSubPointersMut,
    >;
    #[doc(hidden)]
    impl MyInterfaceLibraryDispatcherSubPointersDrop<> of core::traits::Drop<
        MyInterfaceLibraryDispatcherSubPointers,
    >;
    #[doc(hidden)]
    impl MyInterfaceLibraryDispatcherSubPointersCopy<> of core::traits::Copy<
        MyInterfaceLibraryDispatcherSubPointers,
    >;
    #[doc(hidden)]
    impl MyInterfaceLibraryDispatcherSubPointersMutDrop<> of core::traits::Drop<
        MyInterfaceLibraryDispatcherSubPointersMut,
    >;
    #[doc(hidden)]
    impl MyInterfaceLibraryDispatcherSubPointersMutCopy<> of core::traits::Copy<
        MyInterfaceLibraryDispatcherSubPointersMut,
    >;
    #[doc(hidden)]
    impl MyInterfaceSafeLibraryDispatcherSubPointersDrop<> of core::traits::Drop<
        MyInterfaceSafeLibraryDispatcherSubPointers,
    >;
    #[doc(hidden)]
    impl MyInterfaceSafeLibraryDispatcherSubPointersCopy<> of core::traits::Copy<
        MyInterfaceSafeLibraryDispatcherSubPointers,
    >;
    #[doc(hidden)]
    impl MyInterfaceSafeLibraryDispatcherSubPointersMutDrop<> of core::traits::Drop<
        MyInterfaceSafeLibraryDispatcherSubPointersMut,
    >;
    #[doc(hidden)]
    impl MyInterfaceSafeLibraryDispatcherSubPointersMutCopy<> of core::traits::Copy<
        MyInterfaceSafeLibraryDispatcherSubPointersMut,
    >;
    #[doc(hidden)]
    impl MyInterfaceSafeDispatcherSubPointersDrop<> of core::traits::Drop<
        MyInterfaceSafeDispatcherSubPointers,
    >;
    #[doc(hidden)]
    impl MyInterfaceSafeDispatcherSubPointersCopy<> of core::traits::Copy<
        MyInterfaceSafeDispatcherSubPointers,
    >;
    #[doc(hidden)]
    impl MyInterfaceSafeDispatcherSubPointersMutDrop<> of core::traits::Drop<
        MyInterfaceSafeDispatcherSubPointersMut,
    >;
    #[doc(hidden)]
    impl MyInterfaceSafeDispatcherSubPointersMutCopy<> of core::traits::Copy<
        MyInterfaceSafeDispatcherSubPointersMut,
    >;

    mod sn_c1 {
        #[storage]
        struct Storage {}
        #[event]
        #[derive(Drop, starknet::Event)]
        pub enum Event {}


        #[derive(Drop, Copy)]
        #[doc(hidden)]
        struct StorageStorageBase {}
        #[doc(hidden)]
        impl StorageStorageImpl of starknet::storage::StorageTrait<Storage> {
            type BaseType = StorageStorageBase;
            fn storage(self: starknet::storage::FlattenedStorage<Storage>) -> StorageStorageBase {
                StorageStorageBase {}
            }
        }
        #[derive(Drop, Copy)]
        #[doc(hidden)]
        struct StorageStorageBaseMut {}
        #[doc(hidden)]
        impl StorageStorageMutImpl of starknet::storage::StorageTraitMut<Storage> {
            type BaseType = StorageStorageBaseMut;
            fn storage_mut(
                self: starknet::storage::FlattenedStorage<starknet::storage::Mutable<Storage>>,
            ) -> StorageStorageBaseMut {
                StorageStorageBaseMut {}
            }
        }

        pub struct ContractState {}

        impl ContractStateDrop of Drop<ContractState> {}

        impl ContractStateDeref of core::ops::Deref<@ContractState> {
            type Target = starknet::storage::FlattenedStorage<Storage>;
            fn deref(self: @ContractState) -> starknet::storage::FlattenedStorage<Storage> {
                starknet::storage::FlattenedStorage {}
            }
        }
        impl ContractStateDerefMut of core::ops::DerefMut<ContractState> {
            type Target = starknet::storage::FlattenedStorage<starknet::storage::Mutable<Storage>>;
            fn deref_mut(
                ref self: ContractState,
            ) -> starknet::storage::FlattenedStorage<starknet::storage::Mutable<Storage>> {
                starknet::storage::FlattenedStorage {}
            }
        }
        pub fn unsafe_new_contract_state() -> ContractState {
            ContractState {}
        }
        use starknet::storage::Map as LegacyMap;
        impl ContractStateEventEmitter of starknet::event::EventEmitter<ContractState, Event> {
            fn emit<S, impl IntoImp: core::traits::Into<S, Event>>(
                ref self: ContractState, event: S,
            ) {
                let event: Event = core::traits::Into::into(event);
                let mut keys = Default::<core::array::Array>::default();
                let mut data = Default::<core::array::Array>::default();
                starknet::Event::append_keys_and_data(@event, ref keys, ref data);
                starknet::SyscallResultTrait::unwrap_syscall(
                    starknet::syscalls::emit_event_syscall(
                        core::array::ArrayTrait::span(@keys), core::array::ArrayTrait::span(@data),
                    ),
                )
            }
        }
        impl EventDrop<> of core::traits::Drop<Event>;
        impl EventIsEvent of starknet::Event<Event> {
            fn append_keys_and_data(
                self: @Event, ref keys: Array<felt252>, ref data: Array<felt252>,
            ) {
                match self {}
            }
            fn deserialize(ref keys: Span<felt252>, ref data: Span<felt252>) -> Option<Event> {
                let __selector__ = *core::array::SpanTrait::pop_front(ref keys)?;
                Option::None
            }
        }
        #[doc(hidden)]
        impl StorageStorageBaseDrop<> of core::traits::Drop<StorageStorageBase>;
        #[doc(hidden)]
        impl StorageStorageBaseCopy<> of core::traits::Copy<StorageStorageBase>;
        #[doc(hidden)]
        impl StorageStorageBaseMutDrop<> of core::traits::Drop<StorageStorageBaseMut>;
        #[doc(hidden)]
        impl StorageStorageBaseMutCopy<> of core::traits::Copy<StorageStorageBaseMut>;

        mod __external {}

        mod __l1_handler {}

        mod __constructor {}
    }

    mod m_M_definition {
        use super::M;
        pub impl MDefinitionImpl<T> of dojo::model::ModelDefinition<T> {
            #[inline(always)]
            fn name() -> ByteArray {
                "M"
            }

            #[inline(always)]
            fn layout() -> dojo::meta::Layout {
                dojo::meta::Introspect::<M>::layout()
            }

            #[inline(always)]
            fn use_legacy_storage() -> bool {
                false
            }

            #[inline(always)]
            fn schema() -> dojo::meta::introspect::Struct {
                if let dojo::meta::introspect::Ty::Struct(s) = dojo::meta::Introspect::<M>::ty() {
                    s
                } else {
                    panic!("Model M: invalid schema.")
                }
            }

            #[inline(always)]
            fn size() -> Option<usize> {
                dojo::meta::Introspect::<M>::size()
            }
        }
    }

    mod m_M {
        use super::{M, MValue};

        #[storage]
        struct Storage {}

        #[abi(embed_v0)]
        impl M__DojoDeployedModelImpl =
            dojo::model::component::IDeployedModelImpl<ContractState, M>;

        #[abi(embed_v0)]
        impl M__DojoStoredModelImpl =
            dojo::model::component::IStoredModelImpl<ContractState, M>;

        #[abi(embed_v0)]
        impl M__DojoModelImpl =
            dojo::model::component::IModelImpl<ContractState, M>;

        #[abi(per_item)]
        #[generate_trait]
        impl MImpl of IM {
            // Ensures the ABI contains the Model struct, even if never used
            // into as a system input.
            #[external(v0)]
            fn ensure_abi(self: @ContractState, model: M) {
                let _model = model;
            }

            // Outputs ModelValue to allow a simple diff from the ABI compared to the
            // model to retrieved the keys of a model.
            #[external(v0)]
            fn ensure_values(self: @ContractState, value: MValue) {
                let _value = value;
            }

            // Ensures the generated contract has a unique classhash, using
            // a hardcoded hash computed on model and member names.
            #[external(v0)]
            fn ensure_unique(self: @ContractState) {
                let _hash =
                    2849041847227450344427958839906774949501046181878702978795441262043345740368;
            }
        }
        #[event]
        #[derive(Drop, starknet::Event)]
        pub enum Event {}


        #[derive(Drop, Copy)]
        #[doc(hidden)]
        struct StorageStorageBase {}
        #[doc(hidden)]
        impl StorageStorageImpl of starknet::storage::StorageTrait<Storage> {
            type BaseType = StorageStorageBase;
            fn storage(self: starknet::storage::FlattenedStorage<Storage>) -> StorageStorageBase {
                StorageStorageBase {}
            }
        }
        #[derive(Drop, Copy)]
        #[doc(hidden)]
        struct StorageStorageBaseMut {}
        #[doc(hidden)]
        impl StorageStorageMutImpl of starknet::storage::StorageTraitMut<Storage> {
            type BaseType = StorageStorageBaseMut;
            fn storage_mut(
                self: starknet::storage::FlattenedStorage<starknet::storage::Mutable<Storage>>,
            ) -> StorageStorageBaseMut {
                StorageStorageBaseMut {}
            }
        }

        pub struct ContractState {}

        impl ContractStateDrop of Drop<ContractState> {}

        impl ContractStateDeref of core::ops::Deref<@ContractState> {
            type Target = starknet::storage::FlattenedStorage<Storage>;
            fn deref(self: @ContractState) -> starknet::storage::FlattenedStorage<Storage> {
                starknet::storage::FlattenedStorage {}
            }
        }
        impl ContractStateDerefMut of core::ops::DerefMut<ContractState> {
            type Target = starknet::storage::FlattenedStorage<starknet::storage::Mutable<Storage>>;
            fn deref_mut(
                ref self: ContractState,
            ) -> starknet::storage::FlattenedStorage<starknet::storage::Mutable<Storage>> {
                starknet::storage::FlattenedStorage {}
            }
        }
        pub fn unsafe_new_contract_state() -> ContractState {
            ContractState {}
        }
        use starknet::storage::Map as LegacyMap;

        impl ContractStateIDeployedModelImpl of dojo::model::component::UnsafeNewContractStateTraitForIDeployedModelImpl<
            ContractState,
        > {
            fn unsafe_new_contract_state() -> ContractState {
                unsafe_new_contract_state()
            }
        }
        impl ContractStateIStoredModelImpl of dojo::model::component::UnsafeNewContractStateTraitForIStoredModelImpl<
            ContractState,
        > {
            fn unsafe_new_contract_state() -> ContractState {
                unsafe_new_contract_state()
            }
        }
        impl ContractStateIModelImpl of dojo::model::component::UnsafeNewContractStateTraitForIModelImpl<
            ContractState,
        > {
            fn unsafe_new_contract_state() -> ContractState {
                unsafe_new_contract_state()
            }
        }
        #[doc(hidden)]
        #[implicit_precedence(
            core::pedersen::Pedersen,
            core::RangeCheck,
            core::integer::Bitwise,
            core::ec::EcOp,
            core::poseidon::Poseidon,
            core::SegmentArena,
            core::circuit::RangeCheck96,
            core::circuit::AddMod,
            core::circuit::MulMod,
            core::gas::GasBuiltin,
            System,
        )]
        fn __wrapper__MImpl__ensure_abi(mut data: Span<felt252>) -> Span<felt252> {
            core::internal::require_implicit::<System>();
            core::internal::revoke_ap_tracking();
            core::option::OptionTraitImpl::expect(core::gas::withdraw_gas(), 'Out of gas');
            let __arg_model = core::option::OptionTraitImpl::expect(
                core::serde::Serde::<M>::deserialize(ref data), 'Failed to deserialize param #1',
            );
            assert(core::array::SpanTrait::is_empty(data), 'Input too long for arguments');
            core::option::OptionTraitImpl::expect(
                core::gas::withdraw_gas_all(core::gas::get_builtin_costs()), 'Out of gas',
            );
            let mut contract_state = unsafe_new_contract_state();
            MImpl::ensure_abi(@contract_state, __arg_model);
            let mut arr = ArrayTrait::new();
            // References.
            // Result.
            core::array::ArrayTrait::span(@arr)
        }

        #[doc(hidden)]
        #[implicit_precedence(
            core::pedersen::Pedersen,
            core::RangeCheck,
            core::integer::Bitwise,
            core::ec::EcOp,
            core::poseidon::Poseidon,
            core::SegmentArena,
            core::circuit::RangeCheck96,
            core::circuit::AddMod,
            core::circuit::MulMod,
            core::gas::GasBuiltin,
            System,
        )]
        fn __wrapper__MImpl__ensure_values(mut data: Span<felt252>) -> Span<felt252> {
            core::internal::require_implicit::<System>();
            core::internal::revoke_ap_tracking();
            core::option::OptionTraitImpl::expect(core::gas::withdraw_gas(), 'Out of gas');
            let __arg_value = core::option::OptionTraitImpl::expect(
                core::serde::Serde::<MValue>::deserialize(ref data),
                'Failed to deserialize param #1',
            );
            assert(core::array::SpanTrait::is_empty(data), 'Input too long for arguments');
            core::option::OptionTraitImpl::expect(
                core::gas::withdraw_gas_all(core::gas::get_builtin_costs()), 'Out of gas',
            );
            let mut contract_state = unsafe_new_contract_state();
            MImpl::ensure_values(@contract_state, __arg_value);
            let mut arr = ArrayTrait::new();
            // References.
            // Result.
            core::array::ArrayTrait::span(@arr)
        }

        #[doc(hidden)]
        #[implicit_precedence(
            core::pedersen::Pedersen,
            core::RangeCheck,
            core::integer::Bitwise,
            core::ec::EcOp,
            core::poseidon::Poseidon,
            core::SegmentArena,
            core::circuit::RangeCheck96,
            core::circuit::AddMod,
            core::circuit::MulMod,
            core::gas::GasBuiltin,
            System,
        )]
        fn __wrapper__MImpl__ensure_unique(mut data: Span<felt252>) -> Span<felt252> {
            core::internal::require_implicit::<System>();
            core::internal::revoke_ap_tracking();
            core::option::OptionTraitImpl::expect(core::gas::withdraw_gas(), 'Out of gas');

            assert(core::array::SpanTrait::is_empty(data), 'Input too long for arguments');
            core::option::OptionTraitImpl::expect(
                core::gas::withdraw_gas_all(core::gas::get_builtin_costs()), 'Out of gas',
            );
            let mut contract_state = unsafe_new_contract_state();
            MImpl::ensure_unique(@contract_state);
            let mut arr = ArrayTrait::new();
            // References.
            // Result.
            core::array::ArrayTrait::span(@arr)
        }
        impl ContractStateEventEmitter of starknet::event::EventEmitter<ContractState, Event> {
            fn emit<S, impl IntoImp: core::traits::Into<S, Event>>(
                ref self: ContractState, event: S,
            ) {
                let event: Event = core::traits::Into::into(event);
                let mut keys = Default::<core::array::Array>::default();
                let mut data = Default::<core::array::Array>::default();
                starknet::Event::append_keys_and_data(@event, ref keys, ref data);
                starknet::SyscallResultTrait::unwrap_syscall(
                    starknet::syscalls::emit_event_syscall(
                        core::array::ArrayTrait::span(@keys), core::array::ArrayTrait::span(@data),
                    ),
                )
            }
        }
        trait IM {
            // Ensures the ABI contains the Model struct, even if never used
            // into as a system input.
            #[external(v0)]
            fn ensure_abi(self: @ContractState, model: M);

            // Outputs ModelValue to allow a simple diff from the ABI compared to the
            // model to retrieved the keys of a model.
            #[external(v0)]
            fn ensure_values(self: @ContractState, value: MValue);

            // Ensures the generated contract has a unique classhash, using
            // a hardcoded hash computed on model and member names.
            #[external(v0)]
            fn ensure_unique(self: @ContractState);
        }
        impl EventDrop<> of core::traits::Drop<Event>;
        impl EventIsEvent of starknet::Event<Event> {
            fn append_keys_and_data(
                self: @Event, ref keys: Array<felt252>, ref data: Array<felt252>,
            ) {
                match self {}
            }
            fn deserialize(ref keys: Span<felt252>, ref data: Span<felt252>) -> Option<Event> {
                let __selector__ = *core::array::SpanTrait::pop_front(ref keys)?;
                Option::None
            }
        }
        #[doc(hidden)]
        impl StorageStorageBaseDrop<> of core::traits::Drop<StorageStorageBase>;
        #[doc(hidden)]
        impl StorageStorageBaseCopy<> of core::traits::Copy<StorageStorageBase>;
        #[doc(hidden)]
        impl StorageStorageBaseMutDrop<> of core::traits::Drop<StorageStorageBaseMut>;
        #[doc(hidden)]
        impl StorageStorageBaseMutCopy<> of core::traits::Copy<StorageStorageBaseMut>;

        mod __external {
            use super::{
                __wrapper__MImpl__ensure_abi as ensure_abi,
                __wrapper__MImpl__ensure_unique as ensure_unique,
                __wrapper__MImpl__ensure_values as ensure_values,
            };
        }

        mod __l1_handler {}

        mod __constructor {}
    }

    mod e_E {
        use super::{E, EValue};

        #[storage]
        struct Storage {}

        #[abi(embed_v0)]
        impl E__DeployedEventImpl =
            dojo::event::component::IDeployedEventImpl<ContractState, E>;

        #[abi(embed_v0)]
        impl E__StoredEventImpl =
            dojo::event::component::IStoredEventImpl<ContractState, E>;

        #[abi(embed_v0)]
        impl E__EventImpl = dojo::event::component::IEventImpl<ContractState, E>;

        #[abi(per_item)]
        #[generate_trait]
        impl EImpl of IE {
            // Ensures the ABI contains the Event struct, since it's never used
            // by systems directly.
            #[external(v0)]
            fn ensure_abi(self: @ContractState, event: E) {
                let _event = event;
            }

            // Outputs EventValue to allow a simple diff from the ABI compared to the
            // event to retrieved the keys of an event.
            #[external(v0)]
            fn ensure_values(self: @ContractState, value: EValue) {
                let _value = value;
            }

            // Ensures the generated contract has a unique classhash, using
            // a hardcoded hash computed on event and member names.
            #[external(v0)]
            fn ensure_unique(self: @ContractState) {
                let _hash =
                    1954984139733333964498936181682115663372935529816993893359036110076230488447;
            }
        }
        #[event]
        #[derive(Drop, starknet::Event)]
        pub enum Event {}


        #[derive(Drop, Copy)]
        #[doc(hidden)]
        struct StorageStorageBase {}
        #[doc(hidden)]
        impl StorageStorageImpl of starknet::storage::StorageTrait<Storage> {
            type BaseType = StorageStorageBase;
            fn storage(self: starknet::storage::FlattenedStorage<Storage>) -> StorageStorageBase {
                StorageStorageBase {}
            }
        }
        #[derive(Drop, Copy)]
        #[doc(hidden)]
        struct StorageStorageBaseMut {}
        #[doc(hidden)]
        impl StorageStorageMutImpl of starknet::storage::StorageTraitMut<Storage> {
            type BaseType = StorageStorageBaseMut;
            fn storage_mut(
                self: starknet::storage::FlattenedStorage<starknet::storage::Mutable<Storage>>,
            ) -> StorageStorageBaseMut {
                StorageStorageBaseMut {}
            }
        }

        pub struct ContractState {}

        impl ContractStateDrop of Drop<ContractState> {}

        impl ContractStateDeref of core::ops::Deref<@ContractState> {
            type Target = starknet::storage::FlattenedStorage<Storage>;
            fn deref(self: @ContractState) -> starknet::storage::FlattenedStorage<Storage> {
                starknet::storage::FlattenedStorage {}
            }
        }
        impl ContractStateDerefMut of core::ops::DerefMut<ContractState> {
            type Target = starknet::storage::FlattenedStorage<starknet::storage::Mutable<Storage>>;
            fn deref_mut(
                ref self: ContractState,
            ) -> starknet::storage::FlattenedStorage<starknet::storage::Mutable<Storage>> {
                starknet::storage::FlattenedStorage {}
            }
        }
        pub fn unsafe_new_contract_state() -> ContractState {
            ContractState {}
        }
        use starknet::storage::Map as LegacyMap;

        impl ContractStateIDeployedEventImpl of dojo::event::component::UnsafeNewContractStateTraitForIDeployedEventImpl<
            ContractState,
        > {
            fn unsafe_new_contract_state() -> ContractState {
                unsafe_new_contract_state()
            }
        }
        impl ContractStateIStoredEventImpl of dojo::event::component::UnsafeNewContractStateTraitForIStoredEventImpl<
            ContractState,
        > {
            fn unsafe_new_contract_state() -> ContractState {
                unsafe_new_contract_state()
            }
        }
        impl ContractStateIEventImpl of dojo::event::component::UnsafeNewContractStateTraitForIEventImpl<
            ContractState,
        > {
            fn unsafe_new_contract_state() -> ContractState {
                unsafe_new_contract_state()
            }
        }
        #[doc(hidden)]
        #[implicit_precedence(
            core::pedersen::Pedersen,
            core::RangeCheck,
            core::integer::Bitwise,
            core::ec::EcOp,
            core::poseidon::Poseidon,
            core::SegmentArena,
            core::circuit::RangeCheck96,
            core::circuit::AddMod,
            core::circuit::MulMod,
            core::gas::GasBuiltin,
            System,
        )]
        fn __wrapper__EImpl__ensure_abi(mut data: Span<felt252>) -> Span<felt252> {
            core::internal::require_implicit::<System>();
            core::internal::revoke_ap_tracking();
            core::option::OptionTraitImpl::expect(core::gas::withdraw_gas(), 'Out of gas');
            let __arg_event = core::option::OptionTraitImpl::expect(
                core::serde::Serde::<E>::deserialize(ref data), 'Failed to deserialize param #1',
            );
            assert(core::array::SpanTrait::is_empty(data), 'Input too long for arguments');
            core::option::OptionTraitImpl::expect(
                core::gas::withdraw_gas_all(core::gas::get_builtin_costs()), 'Out of gas',
            );
            let mut contract_state = unsafe_new_contract_state();
            EImpl::ensure_abi(@contract_state, __arg_event);
            let mut arr = ArrayTrait::new();
            // References.
            // Result.
            core::array::ArrayTrait::span(@arr)
        }

        #[doc(hidden)]
        #[implicit_precedence(
            core::pedersen::Pedersen,
            core::RangeCheck,
            core::integer::Bitwise,
            core::ec::EcOp,
            core::poseidon::Poseidon,
            core::SegmentArena,
            core::circuit::RangeCheck96,
            core::circuit::AddMod,
            core::circuit::MulMod,
            core::gas::GasBuiltin,
            System,
        )]
        fn __wrapper__EImpl__ensure_values(mut data: Span<felt252>) -> Span<felt252> {
            core::internal::require_implicit::<System>();
            core::internal::revoke_ap_tracking();
            core::option::OptionTraitImpl::expect(core::gas::withdraw_gas(), 'Out of gas');
            let __arg_value = core::option::OptionTraitImpl::expect(
                core::serde::Serde::<EValue>::deserialize(ref data),
                'Failed to deserialize param #1',
            );
            assert(core::array::SpanTrait::is_empty(data), 'Input too long for arguments');
            core::option::OptionTraitImpl::expect(
                core::gas::withdraw_gas_all(core::gas::get_builtin_costs()), 'Out of gas',
            );
            let mut contract_state = unsafe_new_contract_state();
            EImpl::ensure_values(@contract_state, __arg_value);
            let mut arr = ArrayTrait::new();
            // References.
            // Result.
            core::array::ArrayTrait::span(@arr)
        }

        #[doc(hidden)]
        #[implicit_precedence(
            core::pedersen::Pedersen,
            core::RangeCheck,
            core::integer::Bitwise,
            core::ec::EcOp,
            core::poseidon::Poseidon,
            core::SegmentArena,
            core::circuit::RangeCheck96,
            core::circuit::AddMod,
            core::circuit::MulMod,
            core::gas::GasBuiltin,
            System,
        )]
        fn __wrapper__EImpl__ensure_unique(mut data: Span<felt252>) -> Span<felt252> {
            core::internal::require_implicit::<System>();
            core::internal::revoke_ap_tracking();
            core::option::OptionTraitImpl::expect(core::gas::withdraw_gas(), 'Out of gas');

            assert(core::array::SpanTrait::is_empty(data), 'Input too long for arguments');
            core::option::OptionTraitImpl::expect(
                core::gas::withdraw_gas_all(core::gas::get_builtin_costs()), 'Out of gas',
            );
            let mut contract_state = unsafe_new_contract_state();
            EImpl::ensure_unique(@contract_state);
            let mut arr = ArrayTrait::new();
            // References.
            // Result.
            core::array::ArrayTrait::span(@arr)
        }
        impl ContractStateEventEmitter of starknet::event::EventEmitter<ContractState, Event> {
            fn emit<S, impl IntoImp: core::traits::Into<S, Event>>(
                ref self: ContractState, event: S,
            ) {
                let event: Event = core::traits::Into::into(event);
                let mut keys = Default::<core::array::Array>::default();
                let mut data = Default::<core::array::Array>::default();
                starknet::Event::append_keys_and_data(@event, ref keys, ref data);
                starknet::SyscallResultTrait::unwrap_syscall(
                    starknet::syscalls::emit_event_syscall(
                        core::array::ArrayTrait::span(@keys), core::array::ArrayTrait::span(@data),
                    ),
                )
            }
        }
        trait IE {
            // Ensures the ABI contains the Event struct, since it's never used
            // by systems directly.
            #[external(v0)]
            fn ensure_abi(self: @ContractState, event: E);

            // Outputs EventValue to allow a simple diff from the ABI compared to the
            // event to retrieved the keys of an event.
            #[external(v0)]
            fn ensure_values(self: @ContractState, value: EValue);

            // Ensures the generated contract has a unique classhash, using
            // a hardcoded hash computed on event and member names.
            #[external(v0)]
            fn ensure_unique(self: @ContractState);
        }
        impl EventDrop<> of core::traits::Drop<Event>;
        impl EventIsEvent of starknet::Event<Event> {
            fn append_keys_and_data(
                self: @Event, ref keys: Array<felt252>, ref data: Array<felt252>,
            ) {
                match self {}
            }
            fn deserialize(ref keys: Span<felt252>, ref data: Span<felt252>) -> Option<Event> {
                let __selector__ = *core::array::SpanTrait::pop_front(ref keys)?;
                Option::None
            }
        }
        #[doc(hidden)]
        impl StorageStorageBaseDrop<> of core::traits::Drop<StorageStorageBase>;
        #[doc(hidden)]
        impl StorageStorageBaseCopy<> of core::traits::Copy<StorageStorageBase>;
        #[doc(hidden)]
        impl StorageStorageBaseMutDrop<> of core::traits::Drop<StorageStorageBaseMut>;
        #[doc(hidden)]
        impl StorageStorageBaseMutCopy<> of core::traits::Copy<StorageStorageBaseMut>;

        mod __external {
            use super::{
                __wrapper__EImpl__ensure_abi as ensure_abi,
                __wrapper__EImpl__ensure_unique as ensure_unique,
                __wrapper__EImpl__ensure_values as ensure_values,
            };
        }

        mod __l1_handler {}

        mod __constructor {}

        mod e_EH {
            use super::{EH, EHValue};

            #[storage]
            struct Storage {}

            #[abi(embed_v0)]
            impl EH__DeployedEventImpl =
                dojo::event::component::IDeployedEventImpl<ContractState, EH>;

            #[abi(embed_v0)]
            impl EH__StoredEventImpl =
                dojo::event::component::IStoredEventImpl<ContractState, EH>;

            #[abi(embed_v0)]
            impl EH__EventImpl =
                dojo::event::component::IEventImpl<ContractState, EH>;

            #[abi(per_item)]
            #[generate_trait]
            impl EHImpl of IEH {
                // Ensures the ABI contains the Event struct, since it's never used
                // by systems directly.
                #[external(v0)]
                fn ensure_abi(self: @ContractState, event: EH) {
                    let _event = event;
                }

                // Outputs EventValue to allow a simple diff from the ABI compared to the
                // event to retrieved the keys of an event.
                #[external(v0)]
                fn ensure_values(self: @ContractState, value: EHValue) {
                    let _value = value;
                }

                // Ensures the generated contract has a unique classhash, using
                // a hardcoded hash computed on event and member names.
                #[external(v0)]
                fn ensure_unique(self: @ContractState) {
                    let _hash =
                        535079072247699314064384426321757771782747026384720315941531670532077955480;
                }
            }
            #[event]
            #[derive(Drop, starknet::Event)]
            pub enum Event {}


            #[derive(Drop, Copy)]
            #[doc(hidden)]
            struct StorageStorageBase {}
            #[doc(hidden)]
            impl StorageStorageImpl of starknet::storage::StorageTrait<Storage> {
                type BaseType = StorageStorageBase;
                fn storage(
                    self: starknet::storage::FlattenedStorage<Storage>,
                ) -> StorageStorageBase {
                    StorageStorageBase {}
                }
            }
            #[derive(Drop, Copy)]
            #[doc(hidden)]
            struct StorageStorageBaseMut {}
            #[doc(hidden)]
            impl StorageStorageMutImpl of starknet::storage::StorageTraitMut<Storage> {
                type BaseType = StorageStorageBaseMut;
                fn storage_mut(
                    self: starknet::storage::FlattenedStorage<starknet::storage::Mutable<Storage>>,
                ) -> StorageStorageBaseMut {
                    StorageStorageBaseMut {}
                }
            }

            pub struct ContractState {}

            impl ContractStateDrop of Drop<ContractState> {}

            impl ContractStateDeref of core::ops::Deref<@ContractState> {
                type Target = starknet::storage::FlattenedStorage<Storage>;
                fn deref(self: @ContractState) -> starknet::storage::FlattenedStorage<Storage> {
                    starknet::storage::FlattenedStorage {}
                }
            }
            impl ContractStateDerefMut of core::ops::DerefMut<ContractState> {
                type Target =
                    starknet::storage::FlattenedStorage<starknet::storage::Mutable<Storage>>;
                fn deref_mut(
                    ref self: ContractState,
                ) -> starknet::storage::FlattenedStorage<starknet::storage::Mutable<Storage>> {
                    starknet::storage::FlattenedStorage {}
                }
            }
            pub fn unsafe_new_contract_state() -> ContractState {
                ContractState {}
            }
            use starknet::storage::Map as LegacyMap;

            impl ContractStateIDeployedEventImpl of dojo::event::component::UnsafeNewContractStateTraitForIDeployedEventImpl<
                ContractState,
            > {
                fn unsafe_new_contract_state() -> ContractState {
                    unsafe_new_contract_state()
                }
            }
            impl ContractStateIStoredEventImpl of dojo::event::component::UnsafeNewContractStateTraitForIStoredEventImpl<
                ContractState,
            > {
                fn unsafe_new_contract_state() -> ContractState {
                    unsafe_new_contract_state()
                }
            }
            impl ContractStateIEventImpl of dojo::event::component::UnsafeNewContractStateTraitForIEventImpl<
                ContractState,
            > {
                fn unsafe_new_contract_state() -> ContractState {
                    unsafe_new_contract_state()
                }
            }
            #[doc(hidden)]
            #[implicit_precedence(
                core::pedersen::Pedersen,
                core::RangeCheck,
                core::integer::Bitwise,
                core::ec::EcOp,
                core::poseidon::Poseidon,
                core::SegmentArena,
                core::circuit::RangeCheck96,
                core::circuit::AddMod,
                core::circuit::MulMod,
                core::gas::GasBuiltin,
                System,
            )]
            fn __wrapper__EHImpl__ensure_abi(mut data: Span<felt252>) -> Span<felt252> {
                core::internal::require_implicit::<System>();
                core::internal::revoke_ap_tracking();
                core::option::OptionTraitImpl::expect(core::gas::withdraw_gas(), 'Out of gas');
                let __arg_event = core::option::OptionTraitImpl::expect(
                    core::serde::Serde::<EH>::deserialize(ref data),
                    'Failed to deserialize param #1',
                );
                assert(core::array::SpanTrait::is_empty(data), 'Input too long for arguments');
                core::option::OptionTraitImpl::expect(
                    core::gas::withdraw_gas_all(core::gas::get_builtin_costs()), 'Out of gas',
                );
                let mut contract_state = unsafe_new_contract_state();
                EHImpl::ensure_abi(@contract_state, __arg_event);
                let mut arr = ArrayTrait::new();
                // References.
                // Result.
                core::array::ArrayTrait::span(@arr)
            }

            #[doc(hidden)]
            #[implicit_precedence(
                core::pedersen::Pedersen,
                core::RangeCheck,
                core::integer::Bitwise,
                core::ec::EcOp,
                core::poseidon::Poseidon,
                core::SegmentArena,
                core::circuit::RangeCheck96,
                core::circuit::AddMod,
                core::circuit::MulMod,
                core::gas::GasBuiltin,
                System,
            )]
            fn __wrapper__EHImpl__ensure_values(mut data: Span<felt252>) -> Span<felt252> {
                core::internal::require_implicit::<System>();
                core::internal::revoke_ap_tracking();
                core::option::OptionTraitImpl::expect(core::gas::withdraw_gas(), 'Out of gas');
                let __arg_value = core::option::OptionTraitImpl::expect(
                    core::serde::Serde::<EHValue>::deserialize(ref data),
                    'Failed to deserialize param #1',
                );
                assert(core::array::SpanTrait::is_empty(data), 'Input too long for arguments');
                core::option::OptionTraitImpl::expect(
                    core::gas::withdraw_gas_all(core::gas::get_builtin_costs()), 'Out of gas',
                );
                let mut contract_state = unsafe_new_contract_state();
                EHImpl::ensure_values(@contract_state, __arg_value);
                let mut arr = ArrayTrait::new();
                // References.
                // Result.
                core::array::ArrayTrait::span(@arr)
            }

            #[doc(hidden)]
            #[implicit_precedence(
                core::pedersen::Pedersen,
                core::RangeCheck,
                core::integer::Bitwise,
                core::ec::EcOp,
                core::poseidon::Poseidon,
                core::SegmentArena,
                core::circuit::RangeCheck96,
                core::circuit::AddMod,
                core::circuit::MulMod,
                core::gas::GasBuiltin,
                System,
            )]
            fn __wrapper__EHImpl__ensure_unique(mut data: Span<felt252>) -> Span<felt252> {
                core::internal::require_implicit::<System>();
                core::internal::revoke_ap_tracking();
                core::option::OptionTraitImpl::expect(core::gas::withdraw_gas(), 'Out of gas');

                assert(core::array::SpanTrait::is_empty(data), 'Input too long for arguments');
                core::option::OptionTraitImpl::expect(
                    core::gas::withdraw_gas_all(core::gas::get_builtin_costs()), 'Out of gas',
                );
                let mut contract_state = unsafe_new_contract_state();
                EHImpl::ensure_unique(@contract_state);
                let mut arr = ArrayTrait::new();
                // References.
                // Result.
                core::array::ArrayTrait::span(@arr)
            }
            impl ContractStateEventEmitter of starknet::event::EventEmitter<ContractState, Event> {
                fn emit<S, impl IntoImp: core::traits::Into<S, Event>>(
                    ref self: ContractState, event: S,
                ) {
                    let event: Event = core::traits::Into::into(event);
                    let mut keys = Default::<core::array::Array>::default();
                    let mut data = Default::<core::array::Array>::default();
                    starknet::Event::append_keys_and_data(@event, ref keys, ref data);
                    starknet::SyscallResultTrait::unwrap_syscall(
                        starknet::syscalls::emit_event_syscall(
                            core::array::ArrayTrait::span(@keys),
                            core::array::ArrayTrait::span(@data),
                        ),
                    )
                }
            }
            trait IEH {
                // Ensures the ABI contains the Event struct, since it's never used
                // by systems directly.
                #[external(v0)]
                fn ensure_abi(self: @ContractState, event: EH);

                // Outputs EventValue to allow a simple diff from the ABI compared to the
                // event to retrieved the keys of an event.
                #[external(v0)]
                fn ensure_values(self: @ContractState, value: EHValue);

                // Ensures the generated contract has a unique classhash, using
                // a hardcoded hash computed on event and member names.
                #[external(v0)]
                fn ensure_unique(self: @ContractState);
            }
            impl EventDrop<> of core::traits::Drop<Event>;
            impl EventIsEvent of starknet::Event<Event> {
                fn append_keys_and_data(
                    self: @Event, ref keys: Array<felt252>, ref data: Array<felt252>,
                ) {
                    match self {}
                }
                fn deserialize(ref keys: Span<felt252>, ref data: Span<felt252>) -> Option<Event> {
                    let __selector__ = *core::array::SpanTrait::pop_front(ref keys)?;
                    Option::None
                }
            }
            #[doc(hidden)]
            impl StorageStorageBaseDrop<> of core::traits::Drop<StorageStorageBase>;
            #[doc(hidden)]
            impl StorageStorageBaseCopy<> of core::traits::Copy<StorageStorageBase>;
            #[doc(hidden)]
            impl StorageStorageBaseMutDrop<> of core::traits::Drop<StorageStorageBaseMut>;
            #[doc(hidden)]
            impl StorageStorageBaseMutCopy<> of core::traits::Copy<StorageStorageBaseMut>;

            mod __external {
                use super::{
                    __wrapper__EHImpl__ensure_abi as ensure_abi,
                    __wrapper__EHImpl__ensure_unique as ensure_unique,
                    __wrapper__EHImpl__ensure_values as ensure_values,
                };
            }

            mod __l1_handler {}

            mod __constructor {}
        }
    }

    mod c1 {
        use dojo::contract::IContract;
        use dojo::contract::components::upgradeable::upgradeable_cpt;
        use dojo::contract::components::world_provider::world_provider_cpt::InternalTrait as WorldProviderInternal;
        use dojo::contract::components::world_provider::{IWorldProvider, world_provider_cpt};
        use dojo::meta::IDeployedResource;
        #[abi(embed_v0)]
        impl WorldProviderImpl =
            world_provider_cpt::WorldProviderImpl<ContractState>;
        #[abi(embed_v0)]
        impl UpgradeableImpl = upgradeable_cpt::UpgradeableImpl<ContractState>;
        #[abi(embed_v0)]
        pub impl c1__ContractImpl of IContract<ContractState> {}
        #[abi(embed_v0)]
        pub impl DojoDeployedContractImpl of IDeployedResource<ContractState> {
            fn dojo_name(self: @ContractState) -> ByteArray {
                "c1"
            }
        }
        #[generate_trait]
        impl DojoContractInternalImpl of DojoContractInternalTrait {
            fn world(
                self: @ContractState, namespace: @ByteArray,
            ) -> dojo::world::storage::WorldStorage {
                dojo::world::WorldStorageTrait::new(
                    self.world_provider.world_dispatcher(), namespace,
                )
            }
            fn world_ns_hash(
                self: @ContractState, namespace_hash: felt252,
            ) -> dojo::world::storage::WorldStorage {
                dojo::world::WorldStorageTrait::new_from_hash(
                    self.world_provider.world_dispatcher(), namespace_hash,
                )
            }
        }
        use dojo::event::EventStorage;
        use dojo::model::{Model, ModelStorage, ModelValueStorage};
        use super::{E, EH, GameContextDetails, M, MValue, MyInterface, MyInterfaceDispatcherTrait};
        #[abi(per_item)]
        #[generate_trait]
        pub impl IDojoInitImpl of IDojoInit {
            #[external(v0)]
            fn dojo_init(self: @ContractState, v: felt252) {
                if starknet::get_caller_address() != self
                    .world_provider
                    .world_dispatcher()
                    .contract_address {
                    core::panics::panic_with_byte_array(
                        @format!(
                            "Only the world can init contract `{}`, but caller is `{:?}`",
                            self.dojo_name(),
                            starknet::get_caller_address(),
                        ),
                    );
                }
                {
                    let m = M { k: 0, v };

                    let mut world = self.world_default();
                    world.write_model(@m);
                }
            }
        }
        #[abi(embed_v0)]
        impl MyInterfaceImpl of MyInterface<ContractState> {
            fn system_1(ref self: ContractState, k: felt252, v: felt252) {
                let mut world = self.world_default();

                let m = M { k, v };

                world.write_model(@m)
            }

            fn system_2(ref self: ContractState, k: felt252) -> felt252 {
                let mut world = self.world_default();

                let m: M = world.read_model(k);

                m.v
            }

            fn system_3(ref self: ContractState, k: felt252, v: u32) {
                let mut world = self.world_default();

                let e = E { k, v };
                world.emit_event(@e);

                let eh = EH { k, v };
                world.emit_event(@eh);
            }

            fn system_4(ref self: ContractState, k: felt252) {
                let mut world = self.world_default();

                let m = M { k, v: 288 };

                let entity_id = Model::<M>::entity_id(@m);

                world.write_model(@m);
                world.erase_model(@m);

                let mut mv: MValue = world.read_value_from_id(entity_id);
                mv.v = 12;
                world.write_value_from_id(entity_id, @mv);

                world.erase_model_ptr(Model::<M>::ptr_from_id(entity_id));
            }

            fn system_dbg(
                ref self: ContractState,
                objective_ids: Option<Span<u32>>,
                game_context: Option<GameContextDetails>,
            ) {
                let d = super::MyInterfaceDispatcher {
                    contract_address: starknet::get_contract_address(),
                };

                let empty_objective_ids: Span<u32> = array![].span();

                d.system_dbg(Option::Some(empty_objective_ids), None);
            }
        }

        #[generate_trait]
        impl InternalImpl of InternalTrait {
            // Need a function since byte array can't be const.
            // We could have a self.world with an other function to init from hash, that can be
            // constant.
            fn world_default(self: @ContractState) -> dojo::world::WorldStorage {
                self.world(@"ns")
            }
        }
        #[constructor]
        fn constructor(ref self: ContractState) {
            self.world_provider.initializer();
        }
        #[event]
        #[derive(Drop, starknet::Event)]
        enum Event {
            UpgradeableEvent: upgradeable_cpt::Event,
            WorldProviderEvent: world_provider_cpt::Event,
        }
        #[storage]
        struct Storage {
            #[substorage(v0)]
            upgradeable: upgradeable_cpt::Storage,
            #[substorage(v0)]
            world_provider: world_provider_cpt::Storage,
        }
        trait DojoContractInternalTrait {
            fn world(
                self: @ContractState, namespace: @ByteArray,
            ) -> dojo::world::storage::WorldStorage;
            fn world_ns_hash(
                self: @ContractState, namespace_hash: felt252,
            ) -> dojo::world::storage::WorldStorage;
        }
        pub trait IDojoInit {
            #[external(v0)]
            fn dojo_init(self: @ContractState, v: felt252);
        }
        trait InternalTrait {
            // Need a function since byte array can't be const.
            // We could have a self.world with an other function to init from hash, that can be
            // constant.
            fn world_default(self: @ContractState) -> dojo::world::WorldStorage;
        }
        impl EventDrop<> of core::traits::Drop<Event>;
        impl EventIsEvent of starknet::Event<Event> {
            fn append_keys_and_data(
                self: @Event, ref keys: Array<felt252>, ref data: Array<felt252>,
            ) {
                match self {
                    Event::UpgradeableEvent(val) => {
                        core::array::ArrayTrait::append(ref keys, selector!("UpgradeableEvent"));
                        starknet::Event::append_keys_and_data(val, ref keys, ref data);
                    },
                    Event::WorldProviderEvent(val) => {
                        core::array::ArrayTrait::append(ref keys, selector!("WorldProviderEvent"));
                        starknet::Event::append_keys_and_data(val, ref keys, ref data);
                    },
                }
            }
            fn deserialize(ref keys: Span<felt252>, ref data: Span<felt252>) -> Option<Event> {
                let __selector__ = *core::array::SpanTrait::pop_front(ref keys)?;
                if __selector__ == selector!("UpgradeableEvent") {
                    let val = starknet::Event::deserialize(ref keys, ref data)?;
                    return Option::Some(Event::UpgradeableEvent(val));
                }
                if __selector__ == selector!("WorldProviderEvent") {
                    let val = starknet::Event::deserialize(ref keys, ref data)?;
                    return Option::Some(Event::WorldProviderEvent(val));
                }
                Option::None
            }
        }
        impl EventUpgradeableEventIntoEvent of Into<upgradeable_cpt::Event, Event> {
            fn into(self: upgradeable_cpt::Event) -> Event {
                Event::UpgradeableEvent(self)
            }
        }
        impl EventWorldProviderEventIntoEvent of Into<world_provider_cpt::Event, Event> {
            fn into(self: world_provider_cpt::Event) -> Event {
                Event::WorldProviderEvent(self)
            }
        }


        #[derive(Drop, Copy)]
        #[doc(hidden)]
        struct StorageStorageBase {
            #[substorage(v0)]
            upgradeable: starknet::storage::FlattenedStorage<upgradeable_cpt::Storage>,
            #[substorage(v0)]
            world_provider: starknet::storage::FlattenedStorage<world_provider_cpt::Storage>,
        }
        #[doc(hidden)]
        impl StorageStorageImpl of starknet::storage::StorageTrait<Storage> {
            type BaseType = StorageStorageBase;
            fn storage(self: starknet::storage::FlattenedStorage<Storage>) -> StorageStorageBase {
                let __upgradeable_value__ = starknet::storage::FlattenedStorage {};
                let __world_provider_value__ = starknet::storage::FlattenedStorage {};
                StorageStorageBase {
                    upgradeable: __upgradeable_value__, world_provider: __world_provider_value__,
                }
            }
        }
        #[derive(Drop, Copy)]
        #[doc(hidden)]
        struct StorageStorageBaseMut {
            #[substorage(v0)]
            upgradeable: starknet::storage::FlattenedStorage<
                starknet::storage::Mutable<upgradeable_cpt::Storage>,
            >,
            #[substorage(v0)]
            world_provider: starknet::storage::FlattenedStorage<
                starknet::storage::Mutable<world_provider_cpt::Storage>,
            >,
        }
        #[doc(hidden)]
        impl StorageStorageMutImpl of starknet::storage::StorageTraitMut<Storage> {
            type BaseType = StorageStorageBaseMut;
            fn storage_mut(
                self: starknet::storage::FlattenedStorage<starknet::storage::Mutable<Storage>>,
            ) -> StorageStorageBaseMut {
                let __upgradeable_value__ = starknet::storage::FlattenedStorage {};
                let __world_provider_value__ = starknet::storage::FlattenedStorage {};
                StorageStorageBaseMut {
                    upgradeable: __upgradeable_value__, world_provider: __world_provider_value__,
                }
            }
        }

        pub struct ContractState {
            #[substorage(v0)]
            upgradeable: upgradeable_cpt::ComponentState<ContractState>,
            #[substorage(v0)]
            world_provider: world_provider_cpt::ComponentState<ContractState>,
        }

        impl ContractStateDrop of Drop<ContractState> {}

        impl ContractStateDeref of core::ops::Deref<@ContractState> {
            type Target = starknet::storage::FlattenedStorage<Storage>;
            fn deref(self: @ContractState) -> starknet::storage::FlattenedStorage<Storage> {
                starknet::storage::FlattenedStorage {}
            }
        }
        impl ContractStateDerefMut of core::ops::DerefMut<ContractState> {
            type Target = starknet::storage::FlattenedStorage<starknet::storage::Mutable<Storage>>;
            fn deref_mut(
                ref self: ContractState,
            ) -> starknet::storage::FlattenedStorage<starknet::storage::Mutable<Storage>> {
                starknet::storage::FlattenedStorage {}
            }
        }
        pub fn unsafe_new_contract_state() -> ContractState {
            ContractState {
                upgradeable: upgradeable_cpt::unsafe_new_component_state::<ContractState>(),
                world_provider: world_provider_cpt::unsafe_new_component_state::<ContractState>(),
            }
        }
        use starknet::storage::Map as LegacyMap;

        impl ContractStateWorldProviderImpl of world_provider_cpt::UnsafeNewContractStateTraitForWorldProviderImpl<
            ContractState,
        > {
            fn unsafe_new_contract_state() -> ContractState {
                unsafe_new_contract_state()
            }
        }
        impl ContractStateUpgradeableImpl of upgradeable_cpt::UnsafeNewContractStateTraitForUpgradeableImpl<
            ContractState,
        > {
            fn unsafe_new_contract_state() -> ContractState {
                unsafe_new_contract_state()
            }
        }
        #[doc(hidden)]
        #[implicit_precedence(
            core::pedersen::Pedersen,
            core::RangeCheck,
            core::integer::Bitwise,
            core::ec::EcOp,
            core::poseidon::Poseidon,
            core::SegmentArena,
            core::circuit::RangeCheck96,
            core::circuit::AddMod,
            core::circuit::MulMod,
            core::gas::GasBuiltin,
            System,
        )]
        fn __wrapper__DojoDeployedContractImpl__dojo_name(
            mut data: Span<felt252>,
        ) -> Span<felt252> {
            core::internal::require_implicit::<System>();
            core::internal::revoke_ap_tracking();
            core::option::OptionTraitImpl::expect(core::gas::withdraw_gas(), 'Out of gas');

            assert(core::array::SpanTrait::is_empty(data), 'Input too long for arguments');
            core::option::OptionTraitImpl::expect(
                core::gas::withdraw_gas_all(core::gas::get_builtin_costs()), 'Out of gas',
            );
            let mut contract_state = unsafe_new_contract_state();
            let res = DojoDeployedContractImpl::dojo_name(@contract_state);
            let mut arr = ArrayTrait::new();
            // References.
            // Result.
            core::serde::Serde::<ByteArray>::serialize(@res, ref arr);
            core::array::ArrayTrait::span(@arr)
        }

        #[doc(hidden)]
        #[implicit_precedence(
            core::pedersen::Pedersen,
            core::RangeCheck,
            core::integer::Bitwise,
            core::ec::EcOp,
            core::poseidon::Poseidon,
            core::SegmentArena,
            core::circuit::RangeCheck96,
            core::circuit::AddMod,
            core::circuit::MulMod,
            core::gas::GasBuiltin,
            System,
        )]
        fn __wrapper__IDojoInitImpl__dojo_init(mut data: Span<felt252>) -> Span<felt252> {
            core::internal::require_implicit::<System>();
            core::internal::revoke_ap_tracking();
            core::option::OptionTraitImpl::expect(core::gas::withdraw_gas(), 'Out of gas');
            let __arg_v = core::option::OptionTraitImpl::expect(
                core::serde::Serde::<felt252>::deserialize(ref data),
                'Failed to deserialize param #1',
            );
            assert(core::array::SpanTrait::is_empty(data), 'Input too long for arguments');
            core::option::OptionTraitImpl::expect(
                core::gas::withdraw_gas_all(core::gas::get_builtin_costs()), 'Out of gas',
            );
            let mut contract_state = unsafe_new_contract_state();
            IDojoInitImpl::dojo_init(@contract_state, __arg_v);
            let mut arr = ArrayTrait::new();
            // References.
            // Result.
            core::array::ArrayTrait::span(@arr)
        }

        #[doc(hidden)]
        #[implicit_precedence(
            core::pedersen::Pedersen,
            core::RangeCheck,
            core::integer::Bitwise,
            core::ec::EcOp,
            core::poseidon::Poseidon,
            core::SegmentArena,
            core::circuit::RangeCheck96,
            core::circuit::AddMod,
            core::circuit::MulMod,
            core::gas::GasBuiltin,
            System,
        )]
        fn __wrapper__MyInterfaceImpl__system_1(mut data: Span<felt252>) -> Span<felt252> {
            core::internal::require_implicit::<System>();
            core::internal::revoke_ap_tracking();
            core::option::OptionTraitImpl::expect(core::gas::withdraw_gas(), 'Out of gas');
            let __arg_k = core::option::OptionTraitImpl::expect(
                core::serde::Serde::<felt252>::deserialize(ref data),
                'Failed to deserialize param #1',
            );
            let __arg_v = core::option::OptionTraitImpl::expect(
                core::serde::Serde::<felt252>::deserialize(ref data),
                'Failed to deserialize param #2',
            );
            assert(core::array::SpanTrait::is_empty(data), 'Input too long for arguments');
            core::option::OptionTraitImpl::expect(
                core::gas::withdraw_gas_all(core::gas::get_builtin_costs()), 'Out of gas',
            );
            let mut contract_state = unsafe_new_contract_state();
            MyInterfaceImpl::system_1(ref contract_state, __arg_k, __arg_v);
            let mut arr = ArrayTrait::new();
            // References.
            // Result.
            core::array::ArrayTrait::span(@arr)
        }

        #[doc(hidden)]
        #[implicit_precedence(
            core::pedersen::Pedersen,
            core::RangeCheck,
            core::integer::Bitwise,
            core::ec::EcOp,
            core::poseidon::Poseidon,
            core::SegmentArena,
            core::circuit::RangeCheck96,
            core::circuit::AddMod,
            core::circuit::MulMod,
            core::gas::GasBuiltin,
            System,
        )]
        fn __wrapper__MyInterfaceImpl__system_2(mut data: Span<felt252>) -> Span<felt252> {
            core::internal::require_implicit::<System>();
            core::internal::revoke_ap_tracking();
            core::option::OptionTraitImpl::expect(core::gas::withdraw_gas(), 'Out of gas');
            let __arg_k = core::option::OptionTraitImpl::expect(
                core::serde::Serde::<felt252>::deserialize(ref data),
                'Failed to deserialize param #1',
            );
            assert(core::array::SpanTrait::is_empty(data), 'Input too long for arguments');
            core::option::OptionTraitImpl::expect(
                core::gas::withdraw_gas_all(core::gas::get_builtin_costs()), 'Out of gas',
            );
            let mut contract_state = unsafe_new_contract_state();
            let res = MyInterfaceImpl::system_2(ref contract_state, __arg_k);
            let mut arr = ArrayTrait::new();
            // References.
            // Result.
            core::serde::Serde::<felt252>::serialize(@res, ref arr);
            core::array::ArrayTrait::span(@arr)
        }

        #[doc(hidden)]
        #[implicit_precedence(
            core::pedersen::Pedersen,
            core::RangeCheck,
            core::integer::Bitwise,
            core::ec::EcOp,
            core::poseidon::Poseidon,
            core::SegmentArena,
            core::circuit::RangeCheck96,
            core::circuit::AddMod,
            core::circuit::MulMod,
            core::gas::GasBuiltin,
            System,
        )]
        fn __wrapper__MyInterfaceImpl__system_3(mut data: Span<felt252>) -> Span<felt252> {
            core::internal::require_implicit::<System>();
            core::internal::revoke_ap_tracking();
            core::option::OptionTraitImpl::expect(core::gas::withdraw_gas(), 'Out of gas');
            let __arg_k = core::option::OptionTraitImpl::expect(
                core::serde::Serde::<felt252>::deserialize(ref data),
                'Failed to deserialize param #1',
            );
            let __arg_v = core::option::OptionTraitImpl::expect(
                core::serde::Serde::<u32>::deserialize(ref data), 'Failed to deserialize param #2',
            );
            assert(core::array::SpanTrait::is_empty(data), 'Input too long for arguments');
            core::option::OptionTraitImpl::expect(
                core::gas::withdraw_gas_all(core::gas::get_builtin_costs()), 'Out of gas',
            );
            let mut contract_state = unsafe_new_contract_state();
            MyInterfaceImpl::system_3(ref contract_state, __arg_k, __arg_v);
            let mut arr = ArrayTrait::new();
            // References.
            // Result.
            core::array::ArrayTrait::span(@arr)
        }

        #[doc(hidden)]
        #[implicit_precedence(
            core::pedersen::Pedersen,
            core::RangeCheck,
            core::integer::Bitwise,
            core::ec::EcOp,
            core::poseidon::Poseidon,
            core::SegmentArena,
            core::circuit::RangeCheck96,
            core::circuit::AddMod,
            core::circuit::MulMod,
            core::gas::GasBuiltin,
            System,
        )]
        fn __wrapper__MyInterfaceImpl__system_4(mut data: Span<felt252>) -> Span<felt252> {
            core::internal::require_implicit::<System>();
            core::internal::revoke_ap_tracking();
            core::option::OptionTraitImpl::expect(core::gas::withdraw_gas(), 'Out of gas');
            let __arg_k = core::option::OptionTraitImpl::expect(
                core::serde::Serde::<felt252>::deserialize(ref data),
                'Failed to deserialize param #1',
            );
            assert(core::array::SpanTrait::is_empty(data), 'Input too long for arguments');
            core::option::OptionTraitImpl::expect(
                core::gas::withdraw_gas_all(core::gas::get_builtin_costs()), 'Out of gas',
            );
            let mut contract_state = unsafe_new_contract_state();
            MyInterfaceImpl::system_4(ref contract_state, __arg_k);
            let mut arr = ArrayTrait::new();
            // References.
            // Result.
            core::array::ArrayTrait::span(@arr)
        }

        #[doc(hidden)]
        #[implicit_precedence(
            core::pedersen::Pedersen,
            core::RangeCheck,
            core::integer::Bitwise,
            core::ec::EcOp,
            core::poseidon::Poseidon,
            core::SegmentArena,
            core::circuit::RangeCheck96,
            core::circuit::AddMod,
            core::circuit::MulMod,
            core::gas::GasBuiltin,
            System,
        )]
        fn __wrapper__MyInterfaceImpl__system_dbg(mut data: Span<felt252>) -> Span<felt252> {
            core::internal::require_implicit::<System>();
            core::internal::revoke_ap_tracking();
            core::option::OptionTraitImpl::expect(core::gas::withdraw_gas(), 'Out of gas');
            let __arg_objective_ids = core::option::OptionTraitImpl::expect(
                core::serde::Serde::<Option<Span<u32>>>::deserialize(ref data),
                'Failed to deserialize param #1',
            );
            let __arg_game_context = core::option::OptionTraitImpl::expect(
                core::serde::Serde::<Option<GameContextDetails>>::deserialize(ref data),
                'Failed to deserialize param #2',
            );
            assert(core::array::SpanTrait::is_empty(data), 'Input too long for arguments');
            core::option::OptionTraitImpl::expect(
                core::gas::withdraw_gas_all(core::gas::get_builtin_costs()), 'Out of gas',
            );
            let mut contract_state = unsafe_new_contract_state();
            MyInterfaceImpl::system_dbg(
                ref contract_state, __arg_objective_ids, __arg_game_context,
            );
            let mut arr = ArrayTrait::new();
            // References.
            // Result.
            core::array::ArrayTrait::span(@arr)
        }

        #[doc(hidden)]
        #[implicit_precedence(
            core::pedersen::Pedersen,
            core::RangeCheck,
            core::integer::Bitwise,
            core::ec::EcOp,
            core::poseidon::Poseidon,
            core::SegmentArena,
            core::circuit::RangeCheck96,
            core::circuit::AddMod,
            core::circuit::MulMod,
            core::gas::GasBuiltin,
            System,
        )]
        fn __wrapper__constructor(mut data: Span<felt252>) -> Span<felt252> {
            core::internal::require_implicit::<System>();
            core::internal::revoke_ap_tracking();
            core::option::OptionTraitImpl::expect(core::gas::withdraw_gas(), 'Out of gas');

            assert(core::array::SpanTrait::is_empty(data), 'Input too long for arguments');
            core::option::OptionTraitImpl::expect(
                core::gas::withdraw_gas_all(core::gas::get_builtin_costs()), 'Out of gas',
            );
            let mut contract_state = unsafe_new_contract_state();
            constructor(ref contract_state);
            let mut arr = ArrayTrait::new();
            // References.
            // Result.
            core::array::ArrayTrait::span(@arr)
        }
        impl ContractStateEventEmitter of starknet::event::EventEmitter<ContractState, Event> {
            fn emit<S, impl IntoImp: core::traits::Into<S, Event>>(
                ref self: ContractState, event: S,
            ) {
                let event: Event = core::traits::Into::into(event);
                let mut keys = Default::<core::array::Array>::default();
                let mut data = Default::<core::array::Array>::default();
                starknet::Event::append_keys_and_data(@event, ref keys, ref data);
                starknet::SyscallResultTrait::unwrap_syscall(
                    starknet::syscalls::emit_event_syscall(
                        core::array::ArrayTrait::span(@keys), core::array::ArrayTrait::span(@data),
                    ),
                )
            }
        }

        impl HasComponentImpl_world_provider_cpt of world_provider_cpt::HasComponent<
            ContractState,
        > {
            fn get_component(
                self: @ContractState,
            ) -> @world_provider_cpt::ComponentState<ContractState> {
                @world_provider_cpt::unsafe_new_component_state::<ContractState>()
            }
            fn get_component_mut(
                ref self: ContractState,
            ) -> world_provider_cpt::ComponentState<ContractState> {
                world_provider_cpt::unsafe_new_component_state::<ContractState>()
            }
            fn get_contract(
                self: @world_provider_cpt::ComponentState<ContractState>,
            ) -> @ContractState {
                @unsafe_new_contract_state()
            }
            fn get_contract_mut(
                ref self: world_provider_cpt::ComponentState<ContractState>,
            ) -> ContractState {
                unsafe_new_contract_state()
            }
            fn emit<S, impl IntoImp: core::traits::Into<S, world_provider_cpt::Event>>(
                ref self: world_provider_cpt::ComponentState<ContractState>, event: S,
            ) {
                let event: world_provider_cpt::Event = core::traits::Into::into(event);
                let mut contract = world_provider_cpt::HasComponent::get_contract_mut(ref self);
                ContractStateEventEmitter::emit(ref contract, Event::WorldProviderEvent(event));
            }
        }
        impl HasComponentImpl_upgradeable_cpt of upgradeable_cpt::HasComponent<ContractState> {
            fn get_component(
                self: @ContractState,
            ) -> @upgradeable_cpt::ComponentState<ContractState> {
                @upgradeable_cpt::unsafe_new_component_state::<ContractState>()
            }
            fn get_component_mut(
                ref self: ContractState,
            ) -> upgradeable_cpt::ComponentState<ContractState> {
                upgradeable_cpt::unsafe_new_component_state::<ContractState>()
            }
            fn get_contract(
                self: @upgradeable_cpt::ComponentState<ContractState>,
            ) -> @ContractState {
                @unsafe_new_contract_state()
            }
            fn get_contract_mut(
                ref self: upgradeable_cpt::ComponentState<ContractState>,
            ) -> ContractState {
                unsafe_new_contract_state()
            }
            fn emit<S, impl IntoImp: core::traits::Into<S, upgradeable_cpt::Event>>(
                ref self: upgradeable_cpt::ComponentState<ContractState>, event: S,
            ) {
                let event: upgradeable_cpt::Event = core::traits::Into::into(event);
                let mut contract = upgradeable_cpt::HasComponent::get_contract_mut(ref self);
                ContractStateEventEmitter::emit(ref contract, Event::UpgradeableEvent(event));
            }
        }
        #[doc(hidden)]
        impl StorageStorageBaseDrop<> of core::traits::Drop<StorageStorageBase>;
        #[doc(hidden)]
        impl StorageStorageBaseCopy<> of core::traits::Copy<StorageStorageBase>;
        #[doc(hidden)]
        impl StorageStorageBaseMutDrop<> of core::traits::Drop<StorageStorageBaseMut>;
        #[doc(hidden)]
        impl StorageStorageBaseMutCopy<> of core::traits::Copy<StorageStorageBaseMut>;

        mod __external {
            use super::{
                __wrapper__DojoDeployedContractImpl__dojo_name as dojo_name,
                __wrapper__IDojoInitImpl__dojo_init as dojo_init,
                __wrapper__MyInterfaceImpl__system_1 as system_1,
                __wrapper__MyInterfaceImpl__system_2 as system_2,
                __wrapper__MyInterfaceImpl__system_3 as system_3,
                __wrapper__MyInterfaceImpl__system_4 as system_4,
                __wrapper__MyInterfaceImpl__system_dbg as system_dbg,
            };
        }

        mod __l1_handler {}

        mod __constructor {
            use super::__wrapper__constructor as constructor;
        }
    }

    mod c2 {
        use dojo::contract::IContract;
        use dojo::contract::components::upgradeable::upgradeable_cpt;
        use dojo::contract::components::world_provider::world_provider_cpt::InternalTrait as WorldProviderInternal;
        use dojo::contract::components::world_provider::{IWorldProvider, world_provider_cpt};
        use dojo::meta::IDeployedResource;
        #[abi(embed_v0)]
        impl WorldProviderImpl =
            world_provider_cpt::WorldProviderImpl<ContractState>;
        #[abi(embed_v0)]
        impl UpgradeableImpl = upgradeable_cpt::UpgradeableImpl<ContractState>;
        #[abi(embed_v0)]
        pub impl c2__ContractImpl of IContract<ContractState> {}
        #[abi(embed_v0)]
        pub impl DojoDeployedContractImpl of IDeployedResource<ContractState> {
            fn dojo_name(self: @ContractState) -> ByteArray {
                "c2"
            }
        }
        #[generate_trait]
        impl DojoContractInternalImpl of DojoContractInternalTrait {
            fn world(
                self: @ContractState, namespace: @ByteArray,
            ) -> dojo::world::storage::WorldStorage {
                dojo::world::WorldStorageTrait::new(
                    self.world_provider.world_dispatcher(), namespace,
                )
            }
            fn world_ns_hash(
                self: @ContractState, namespace_hash: felt252,
            ) -> dojo::world::storage::WorldStorage {
                dojo::world::WorldStorageTrait::new_from_hash(
                    self.world_provider.world_dispatcher(), namespace_hash,
                )
            }
        }
        #[constructor]
        fn constructor(ref self: ContractState) {
            self.world_provider.initializer();
        }
        #[abi(per_item)]
        #[generate_trait]
        pub impl IDojoInitImpl of IDojoInit {
            #[external(v0)]
            fn dojo_init(self: @ContractState) {
                if starknet::get_caller_address() != self
                    .world_provider
                    .world_dispatcher()
                    .contract_address {
                    core::panics::panic_with_byte_array(
                        @format!(
                            "Only the world can init contract `{}`, but caller is `{:?}`",
                            self.dojo_name(),
                            starknet::get_caller_address(),
                        ),
                    );
                }
            }
        }
        #[event]
        #[derive(Drop, starknet::Event)]
        enum Event {
            UpgradeableEvent: upgradeable_cpt::Event,
            WorldProviderEvent: world_provider_cpt::Event,
        }
        #[storage]
        struct Storage {
            #[substorage(v0)]
            upgradeable: upgradeable_cpt::Storage,
            #[substorage(v0)]
            world_provider: world_provider_cpt::Storage,
        }
        trait DojoContractInternalTrait {
            fn world(
                self: @ContractState, namespace: @ByteArray,
            ) -> dojo::world::storage::WorldStorage;
            fn world_ns_hash(
                self: @ContractState, namespace_hash: felt252,
            ) -> dojo::world::storage::WorldStorage;
        }
        pub trait IDojoInit {
            #[external(v0)]
            fn dojo_init(self: @ContractState);
        }
        impl EventDrop<> of core::traits::Drop<Event>;
        impl EventIsEvent of starknet::Event<Event> {
            fn append_keys_and_data(
                self: @Event, ref keys: Array<felt252>, ref data: Array<felt252>,
            ) {
                match self {
                    Event::UpgradeableEvent(val) => {
                        core::array::ArrayTrait::append(ref keys, selector!("UpgradeableEvent"));
                        starknet::Event::append_keys_and_data(val, ref keys, ref data);
                    },
                    Event::WorldProviderEvent(val) => {
                        core::array::ArrayTrait::append(ref keys, selector!("WorldProviderEvent"));
                        starknet::Event::append_keys_and_data(val, ref keys, ref data);
                    },
                }
            }
            fn deserialize(ref keys: Span<felt252>, ref data: Span<felt252>) -> Option<Event> {
                let __selector__ = *core::array::SpanTrait::pop_front(ref keys)?;
                if __selector__ == selector!("UpgradeableEvent") {
                    let val = starknet::Event::deserialize(ref keys, ref data)?;
                    return Option::Some(Event::UpgradeableEvent(val));
                }
                if __selector__ == selector!("WorldProviderEvent") {
                    let val = starknet::Event::deserialize(ref keys, ref data)?;
                    return Option::Some(Event::WorldProviderEvent(val));
                }
                Option::None
            }
        }
        impl EventUpgradeableEventIntoEvent of Into<upgradeable_cpt::Event, Event> {
            fn into(self: upgradeable_cpt::Event) -> Event {
                Event::UpgradeableEvent(self)
            }
        }
        impl EventWorldProviderEventIntoEvent of Into<world_provider_cpt::Event, Event> {
            fn into(self: world_provider_cpt::Event) -> Event {
                Event::WorldProviderEvent(self)
            }
        }


        #[derive(Drop, Copy)]
        #[doc(hidden)]
        struct StorageStorageBase {
            #[substorage(v0)]
            upgradeable: starknet::storage::FlattenedStorage<upgradeable_cpt::Storage>,
            #[substorage(v0)]
            world_provider: starknet::storage::FlattenedStorage<world_provider_cpt::Storage>,
        }
        #[doc(hidden)]
        impl StorageStorageImpl of starknet::storage::StorageTrait<Storage> {
            type BaseType = StorageStorageBase;
            fn storage(self: starknet::storage::FlattenedStorage<Storage>) -> StorageStorageBase {
                let __upgradeable_value__ = starknet::storage::FlattenedStorage {};
                let __world_provider_value__ = starknet::storage::FlattenedStorage {};
                StorageStorageBase {
                    upgradeable: __upgradeable_value__, world_provider: __world_provider_value__,
                }
            }
        }
        #[derive(Drop, Copy)]
        #[doc(hidden)]
        struct StorageStorageBaseMut {
            #[substorage(v0)]
            upgradeable: starknet::storage::FlattenedStorage<
                starknet::storage::Mutable<upgradeable_cpt::Storage>,
            >,
            #[substorage(v0)]
            world_provider: starknet::storage::FlattenedStorage<
                starknet::storage::Mutable<world_provider_cpt::Storage>,
            >,
        }
        #[doc(hidden)]
        impl StorageStorageMutImpl of starknet::storage::StorageTraitMut<Storage> {
            type BaseType = StorageStorageBaseMut;
            fn storage_mut(
                self: starknet::storage::FlattenedStorage<starknet::storage::Mutable<Storage>>,
            ) -> StorageStorageBaseMut {
                let __upgradeable_value__ = starknet::storage::FlattenedStorage {};
                let __world_provider_value__ = starknet::storage::FlattenedStorage {};
                StorageStorageBaseMut {
                    upgradeable: __upgradeable_value__, world_provider: __world_provider_value__,
                }
            }
        }

        pub struct ContractState {
            #[substorage(v0)]
            upgradeable: upgradeable_cpt::ComponentState<ContractState>,
            #[substorage(v0)]
            world_provider: world_provider_cpt::ComponentState<ContractState>,
        }

        impl ContractStateDrop of Drop<ContractState> {}

        impl ContractStateDeref of core::ops::Deref<@ContractState> {
            type Target = starknet::storage::FlattenedStorage<Storage>;
            fn deref(self: @ContractState) -> starknet::storage::FlattenedStorage<Storage> {
                starknet::storage::FlattenedStorage {}
            }
        }
        impl ContractStateDerefMut of core::ops::DerefMut<ContractState> {
            type Target = starknet::storage::FlattenedStorage<starknet::storage::Mutable<Storage>>;
            fn deref_mut(
                ref self: ContractState,
            ) -> starknet::storage::FlattenedStorage<starknet::storage::Mutable<Storage>> {
                starknet::storage::FlattenedStorage {}
            }
        }
        pub fn unsafe_new_contract_state() -> ContractState {
            ContractState {
                upgradeable: upgradeable_cpt::unsafe_new_component_state::<ContractState>(),
                world_provider: world_provider_cpt::unsafe_new_component_state::<ContractState>(),
            }
        }
        use starknet::storage::Map as LegacyMap;

        impl ContractStateWorldProviderImpl of world_provider_cpt::UnsafeNewContractStateTraitForWorldProviderImpl<
            ContractState,
        > {
            fn unsafe_new_contract_state() -> ContractState {
                unsafe_new_contract_state()
            }
        }
        impl ContractStateUpgradeableImpl of upgradeable_cpt::UnsafeNewContractStateTraitForUpgradeableImpl<
            ContractState,
        > {
            fn unsafe_new_contract_state() -> ContractState {
                unsafe_new_contract_state()
            }
        }
        #[doc(hidden)]
        #[implicit_precedence(
            core::pedersen::Pedersen,
            core::RangeCheck,
            core::integer::Bitwise,
            core::ec::EcOp,
            core::poseidon::Poseidon,
            core::SegmentArena,
            core::circuit::RangeCheck96,
            core::circuit::AddMod,
            core::circuit::MulMod,
            core::gas::GasBuiltin,
            System,
        )]
        fn __wrapper__DojoDeployedContractImpl__dojo_name(
            mut data: Span<felt252>,
        ) -> Span<felt252> {
            core::internal::require_implicit::<System>();
            core::internal::revoke_ap_tracking();
            core::option::OptionTraitImpl::expect(core::gas::withdraw_gas(), 'Out of gas');

            assert(core::array::SpanTrait::is_empty(data), 'Input too long for arguments');
            core::option::OptionTraitImpl::expect(
                core::gas::withdraw_gas_all(core::gas::get_builtin_costs()), 'Out of gas',
            );
            let mut contract_state = unsafe_new_contract_state();
            let res = DojoDeployedContractImpl::dojo_name(@contract_state);
            let mut arr = ArrayTrait::new();
            // References.
            // Result.
            core::serde::Serde::<ByteArray>::serialize(@res, ref arr);
            core::array::ArrayTrait::span(@arr)
        }

        #[doc(hidden)]
        #[implicit_precedence(
            core::pedersen::Pedersen,
            core::RangeCheck,
            core::integer::Bitwise,
            core::ec::EcOp,
            core::poseidon::Poseidon,
            core::SegmentArena,
            core::circuit::RangeCheck96,
            core::circuit::AddMod,
            core::circuit::MulMod,
            core::gas::GasBuiltin,
            System,
        )]
        fn __wrapper__constructor(mut data: Span<felt252>) -> Span<felt252> {
            core::internal::require_implicit::<System>();
            core::internal::revoke_ap_tracking();
            core::option::OptionTraitImpl::expect(core::gas::withdraw_gas(), 'Out of gas');

            assert(core::array::SpanTrait::is_empty(data), 'Input too long for arguments');
            core::option::OptionTraitImpl::expect(
                core::gas::withdraw_gas_all(core::gas::get_builtin_costs()), 'Out of gas',
            );
            let mut contract_state = unsafe_new_contract_state();
            constructor(ref contract_state);
            let mut arr = ArrayTrait::new();
            // References.
            // Result.
            core::array::ArrayTrait::span(@arr)
        }

        #[doc(hidden)]
        #[implicit_precedence(
            core::pedersen::Pedersen,
            core::RangeCheck,
            core::integer::Bitwise,
            core::ec::EcOp,
            core::poseidon::Poseidon,
            core::SegmentArena,
            core::circuit::RangeCheck96,
            core::circuit::AddMod,
            core::circuit::MulMod,
            core::gas::GasBuiltin,
            System,
        )]
        fn __wrapper__IDojoInitImpl__dojo_init(mut data: Span<felt252>) -> Span<felt252> {
            core::internal::require_implicit::<System>();
            core::internal::revoke_ap_tracking();
            core::option::OptionTraitImpl::expect(core::gas::withdraw_gas(), 'Out of gas');

            assert(core::array::SpanTrait::is_empty(data), 'Input too long for arguments');
            core::option::OptionTraitImpl::expect(
                core::gas::withdraw_gas_all(core::gas::get_builtin_costs()), 'Out of gas',
            );
            let mut contract_state = unsafe_new_contract_state();
            IDojoInitImpl::dojo_init(@contract_state);
            let mut arr = ArrayTrait::new();
            // References.
            // Result.
            core::array::ArrayTrait::span(@arr)
        }
        impl ContractStateEventEmitter of starknet::event::EventEmitter<ContractState, Event> {
            fn emit<S, impl IntoImp: core::traits::Into<S, Event>>(
                ref self: ContractState, event: S,
            ) {
                let event: Event = core::traits::Into::into(event);
                let mut keys = Default::<core::array::Array>::default();
                let mut data = Default::<core::array::Array>::default();
                starknet::Event::append_keys_and_data(@event, ref keys, ref data);
                starknet::SyscallResultTrait::unwrap_syscall(
                    starknet::syscalls::emit_event_syscall(
                        core::array::ArrayTrait::span(@keys), core::array::ArrayTrait::span(@data),
                    ),
                )
            }
        }

        impl HasComponentImpl_world_provider_cpt of world_provider_cpt::HasComponent<
            ContractState,
        > {
            fn get_component(
                self: @ContractState,
            ) -> @world_provider_cpt::ComponentState<ContractState> {
                @world_provider_cpt::unsafe_new_component_state::<ContractState>()
            }
            fn get_component_mut(
                ref self: ContractState,
            ) -> world_provider_cpt::ComponentState<ContractState> {
                world_provider_cpt::unsafe_new_component_state::<ContractState>()
            }
            fn get_contract(
                self: @world_provider_cpt::ComponentState<ContractState>,
            ) -> @ContractState {
                @unsafe_new_contract_state()
            }
            fn get_contract_mut(
                ref self: world_provider_cpt::ComponentState<ContractState>,
            ) -> ContractState {
                unsafe_new_contract_state()
            }
            fn emit<S, impl IntoImp: core::traits::Into<S, world_provider_cpt::Event>>(
                ref self: world_provider_cpt::ComponentState<ContractState>, event: S,
            ) {
                let event: world_provider_cpt::Event = core::traits::Into::into(event);
                let mut contract = world_provider_cpt::HasComponent::get_contract_mut(ref self);
                ContractStateEventEmitter::emit(ref contract, Event::WorldProviderEvent(event));
            }
        }
        impl HasComponentImpl_upgradeable_cpt of upgradeable_cpt::HasComponent<ContractState> {
            fn get_component(
                self: @ContractState,
            ) -> @upgradeable_cpt::ComponentState<ContractState> {
                @upgradeable_cpt::unsafe_new_component_state::<ContractState>()
            }
            fn get_component_mut(
                ref self: ContractState,
            ) -> upgradeable_cpt::ComponentState<ContractState> {
                upgradeable_cpt::unsafe_new_component_state::<ContractState>()
            }
            fn get_contract(
                self: @upgradeable_cpt::ComponentState<ContractState>,
            ) -> @ContractState {
                @unsafe_new_contract_state()
            }
            fn get_contract_mut(
                ref self: upgradeable_cpt::ComponentState<ContractState>,
            ) -> ContractState {
                unsafe_new_contract_state()
            }
            fn emit<S, impl IntoImp: core::traits::Into<S, upgradeable_cpt::Event>>(
                ref self: upgradeable_cpt::ComponentState<ContractState>, event: S,
            ) {
                let event: upgradeable_cpt::Event = core::traits::Into::into(event);
                let mut contract = upgradeable_cpt::HasComponent::get_contract_mut(ref self);
                ContractStateEventEmitter::emit(ref contract, Event::UpgradeableEvent(event));
            }
        }
        #[doc(hidden)]
        impl StorageStorageBaseDrop<> of core::traits::Drop<StorageStorageBase>;
        #[doc(hidden)]
        impl StorageStorageBaseCopy<> of core::traits::Copy<StorageStorageBase>;
        #[doc(hidden)]
        impl StorageStorageBaseMutDrop<> of core::traits::Drop<StorageStorageBaseMut>;
        #[doc(hidden)]
        impl StorageStorageBaseMutCopy<> of core::traits::Copy<StorageStorageBaseMut>;

        mod __external {
            use super::{
                __wrapper__DojoDeployedContractImpl__dojo_name as dojo_name,
                __wrapper__IDojoInitImpl__dojo_init as dojo_init,
            };
        }

        mod __l1_handler {}

        mod __constructor {
            use super::__wrapper__constructor as constructor;
        }
    }

    mod c3 {
        use dojo::contract::IContract;
        use dojo::contract::components::upgradeable::upgradeable_cpt;
        use dojo::contract::components::world_provider::world_provider_cpt::InternalTrait as WorldProviderInternal;
        use dojo::contract::components::world_provider::{IWorldProvider, world_provider_cpt};
        use dojo::meta::IDeployedResource;
        #[abi(embed_v0)]
        impl WorldProviderImpl =
            world_provider_cpt::WorldProviderImpl<ContractState>;
        #[abi(embed_v0)]
        impl UpgradeableImpl = upgradeable_cpt::UpgradeableImpl<ContractState>;
        #[abi(embed_v0)]
        pub impl c3__ContractImpl of IContract<ContractState> {}
        #[abi(embed_v0)]
        pub impl DojoDeployedContractImpl of IDeployedResource<ContractState> {
            fn dojo_name(self: @ContractState) -> ByteArray {
                "c3"
            }
        }
        #[generate_trait]
        impl DojoContractInternalImpl of DojoContractInternalTrait {
            fn world(
                self: @ContractState, namespace: @ByteArray,
            ) -> dojo::world::storage::WorldStorage {
                dojo::world::WorldStorageTrait::new(
                    self.world_provider.world_dispatcher(), namespace,
                )
            }
            fn world_ns_hash(
                self: @ContractState, namespace_hash: felt252,
            ) -> dojo::world::storage::WorldStorage {
                dojo::world::WorldStorageTrait::new_from_hash(
                    self.world_provider.world_dispatcher(), namespace_hash,
                )
            }
        }
        #[constructor]
        fn constructor(ref self: ContractState) {
            self.world_provider.initializer();
        }
        #[abi(per_item)]
        #[generate_trait]
        pub impl IDojoInitImpl of IDojoInit {
            #[external(v0)]
            fn dojo_init(self: @ContractState) {
                if starknet::get_caller_address() != self
                    .world_provider
                    .world_dispatcher()
                    .contract_address {
                    core::panics::panic_with_byte_array(
                        @format!(
                            "Only the world can init contract `{}`, but caller is `{:?}`",
                            self.dojo_name(),
                            starknet::get_caller_address(),
                        ),
                    );
                }
            }
        }
        #[event]
        #[derive(Drop, starknet::Event)]
        enum Event {
            UpgradeableEvent: upgradeable_cpt::Event,
            WorldProviderEvent: world_provider_cpt::Event,
        }
        #[storage]
        struct Storage {
            #[substorage(v0)]
            upgradeable: upgradeable_cpt::Storage,
            #[substorage(v0)]
            world_provider: world_provider_cpt::Storage,
        }
        trait DojoContractInternalTrait {
            fn world(
                self: @ContractState, namespace: @ByteArray,
            ) -> dojo::world::storage::WorldStorage;
            fn world_ns_hash(
                self: @ContractState, namespace_hash: felt252,
            ) -> dojo::world::storage::WorldStorage;
        }
        pub trait IDojoInit {
            #[external(v0)]
            fn dojo_init(self: @ContractState);
        }
        impl EventDrop<> of core::traits::Drop<Event>;
        impl EventIsEvent of starknet::Event<Event> {
            fn append_keys_and_data(
                self: @Event, ref keys: Array<felt252>, ref data: Array<felt252>,
            ) {
                match self {
                    Event::UpgradeableEvent(val) => {
                        core::array::ArrayTrait::append(ref keys, selector!("UpgradeableEvent"));
                        starknet::Event::append_keys_and_data(val, ref keys, ref data);
                    },
                    Event::WorldProviderEvent(val) => {
                        core::array::ArrayTrait::append(ref keys, selector!("WorldProviderEvent"));
                        starknet::Event::append_keys_and_data(val, ref keys, ref data);
                    },
                }
            }
            fn deserialize(ref keys: Span<felt252>, ref data: Span<felt252>) -> Option<Event> {
                let __selector__ = *core::array::SpanTrait::pop_front(ref keys)?;
                if __selector__ == selector!("UpgradeableEvent") {
                    let val = starknet::Event::deserialize(ref keys, ref data)?;
                    return Option::Some(Event::UpgradeableEvent(val));
                }
                if __selector__ == selector!("WorldProviderEvent") {
                    let val = starknet::Event::deserialize(ref keys, ref data)?;
                    return Option::Some(Event::WorldProviderEvent(val));
                }
                Option::None
            }
        }
        impl EventUpgradeableEventIntoEvent of Into<upgradeable_cpt::Event, Event> {
            fn into(self: upgradeable_cpt::Event) -> Event {
                Event::UpgradeableEvent(self)
            }
        }
        impl EventWorldProviderEventIntoEvent of Into<world_provider_cpt::Event, Event> {
            fn into(self: world_provider_cpt::Event) -> Event {
                Event::WorldProviderEvent(self)
            }
        }


        #[derive(Drop, Copy)]
        #[doc(hidden)]
        struct StorageStorageBase {
            #[substorage(v0)]
            upgradeable: starknet::storage::FlattenedStorage<upgradeable_cpt::Storage>,
            #[substorage(v0)]
            world_provider: starknet::storage::FlattenedStorage<world_provider_cpt::Storage>,
        }
        #[doc(hidden)]
        impl StorageStorageImpl of starknet::storage::StorageTrait<Storage> {
            type BaseType = StorageStorageBase;
            fn storage(self: starknet::storage::FlattenedStorage<Storage>) -> StorageStorageBase {
                let __upgradeable_value__ = starknet::storage::FlattenedStorage {};
                let __world_provider_value__ = starknet::storage::FlattenedStorage {};
                StorageStorageBase {
                    upgradeable: __upgradeable_value__, world_provider: __world_provider_value__,
                }
            }
        }
        #[derive(Drop, Copy)]
        #[doc(hidden)]
        struct StorageStorageBaseMut {
            #[substorage(v0)]
            upgradeable: starknet::storage::FlattenedStorage<
                starknet::storage::Mutable<upgradeable_cpt::Storage>,
            >,
            #[substorage(v0)]
            world_provider: starknet::storage::FlattenedStorage<
                starknet::storage::Mutable<world_provider_cpt::Storage>,
            >,
        }
        #[doc(hidden)]
        impl StorageStorageMutImpl of starknet::storage::StorageTraitMut<Storage> {
            type BaseType = StorageStorageBaseMut;
            fn storage_mut(
                self: starknet::storage::FlattenedStorage<starknet::storage::Mutable<Storage>>,
            ) -> StorageStorageBaseMut {
                let __upgradeable_value__ = starknet::storage::FlattenedStorage {};
                let __world_provider_value__ = starknet::storage::FlattenedStorage {};
                StorageStorageBaseMut {
                    upgradeable: __upgradeable_value__, world_provider: __world_provider_value__,
                }
            }
        }

        pub struct ContractState {
            #[substorage(v0)]
            upgradeable: upgradeable_cpt::ComponentState<ContractState>,
            #[substorage(v0)]
            world_provider: world_provider_cpt::ComponentState<ContractState>,
        }

        impl ContractStateDrop of Drop<ContractState> {}

        impl ContractStateDeref of core::ops::Deref<@ContractState> {
            type Target = starknet::storage::FlattenedStorage<Storage>;
            fn deref(self: @ContractState) -> starknet::storage::FlattenedStorage<Storage> {
                starknet::storage::FlattenedStorage {}
            }
        }
        impl ContractStateDerefMut of core::ops::DerefMut<ContractState> {
            type Target = starknet::storage::FlattenedStorage<starknet::storage::Mutable<Storage>>;
            fn deref_mut(
                ref self: ContractState,
            ) -> starknet::storage::FlattenedStorage<starknet::storage::Mutable<Storage>> {
                starknet::storage::FlattenedStorage {}
            }
        }
        pub fn unsafe_new_contract_state() -> ContractState {
            ContractState {
                upgradeable: upgradeable_cpt::unsafe_new_component_state::<ContractState>(),
                world_provider: world_provider_cpt::unsafe_new_component_state::<ContractState>(),
            }
        }
        use starknet::storage::Map as LegacyMap;

        impl ContractStateWorldProviderImpl of world_provider_cpt::UnsafeNewContractStateTraitForWorldProviderImpl<
            ContractState,
        > {
            fn unsafe_new_contract_state() -> ContractState {
                unsafe_new_contract_state()
            }
        }
        impl ContractStateUpgradeableImpl of upgradeable_cpt::UnsafeNewContractStateTraitForUpgradeableImpl<
            ContractState,
        > {
            fn unsafe_new_contract_state() -> ContractState {
                unsafe_new_contract_state()
            }
        }
        #[doc(hidden)]
        #[implicit_precedence(
            core::pedersen::Pedersen,
            core::RangeCheck,
            core::integer::Bitwise,
            core::ec::EcOp,
            core::poseidon::Poseidon,
            core::SegmentArena,
            core::circuit::RangeCheck96,
            core::circuit::AddMod,
            core::circuit::MulMod,
            core::gas::GasBuiltin,
            System,
        )]
        fn __wrapper__DojoDeployedContractImpl__dojo_name(
            mut data: Span<felt252>,
        ) -> Span<felt252> {
            core::internal::require_implicit::<System>();
            core::internal::revoke_ap_tracking();
            core::option::OptionTraitImpl::expect(core::gas::withdraw_gas(), 'Out of gas');

            assert(core::array::SpanTrait::is_empty(data), 'Input too long for arguments');
            core::option::OptionTraitImpl::expect(
                core::gas::withdraw_gas_all(core::gas::get_builtin_costs()), 'Out of gas',
            );
            let mut contract_state = unsafe_new_contract_state();
            let res = DojoDeployedContractImpl::dojo_name(@contract_state);
            let mut arr = ArrayTrait::new();
            // References.
            // Result.
            core::serde::Serde::<ByteArray>::serialize(@res, ref arr);
            core::array::ArrayTrait::span(@arr)
        }

        #[doc(hidden)]
        #[implicit_precedence(
            core::pedersen::Pedersen,
            core::RangeCheck,
            core::integer::Bitwise,
            core::ec::EcOp,
            core::poseidon::Poseidon,
            core::SegmentArena,
            core::circuit::RangeCheck96,
            core::circuit::AddMod,
            core::circuit::MulMod,
            core::gas::GasBuiltin,
            System,
        )]
        fn __wrapper__constructor(mut data: Span<felt252>) -> Span<felt252> {
            core::internal::require_implicit::<System>();
            core::internal::revoke_ap_tracking();
            core::option::OptionTraitImpl::expect(core::gas::withdraw_gas(), 'Out of gas');

            assert(core::array::SpanTrait::is_empty(data), 'Input too long for arguments');
            core::option::OptionTraitImpl::expect(
                core::gas::withdraw_gas_all(core::gas::get_builtin_costs()), 'Out of gas',
            );
            let mut contract_state = unsafe_new_contract_state();
            constructor(ref contract_state);
            let mut arr = ArrayTrait::new();
            // References.
            // Result.
            core::array::ArrayTrait::span(@arr)
        }

        #[doc(hidden)]
        #[implicit_precedence(
            core::pedersen::Pedersen,
            core::RangeCheck,
            core::integer::Bitwise,
            core::ec::EcOp,
            core::poseidon::Poseidon,
            core::SegmentArena,
            core::circuit::RangeCheck96,
            core::circuit::AddMod,
            core::circuit::MulMod,
            core::gas::GasBuiltin,
            System,
        )]
        fn __wrapper__IDojoInitImpl__dojo_init(mut data: Span<felt252>) -> Span<felt252> {
            core::internal::require_implicit::<System>();
            core::internal::revoke_ap_tracking();
            core::option::OptionTraitImpl::expect(core::gas::withdraw_gas(), 'Out of gas');

            assert(core::array::SpanTrait::is_empty(data), 'Input too long for arguments');
            core::option::OptionTraitImpl::expect(
                core::gas::withdraw_gas_all(core::gas::get_builtin_costs()), 'Out of gas',
            );
            let mut contract_state = unsafe_new_contract_state();
            IDojoInitImpl::dojo_init(@contract_state);
            let mut arr = ArrayTrait::new();
            // References.
            // Result.
            core::array::ArrayTrait::span(@arr)
        }
        impl ContractStateEventEmitter of starknet::event::EventEmitter<ContractState, Event> {
            fn emit<S, impl IntoImp: core::traits::Into<S, Event>>(
                ref self: ContractState, event: S,
            ) {
                let event: Event = core::traits::Into::into(event);
                let mut keys = Default::<core::array::Array>::default();
                let mut data = Default::<core::array::Array>::default();
                starknet::Event::append_keys_and_data(@event, ref keys, ref data);
                starknet::SyscallResultTrait::unwrap_syscall(
                    starknet::syscalls::emit_event_syscall(
                        core::array::ArrayTrait::span(@keys), core::array::ArrayTrait::span(@data),
                    ),
                )
            }
        }

        impl HasComponentImpl_world_provider_cpt of world_provider_cpt::HasComponent<
            ContractState,
        > {
            fn get_component(
                self: @ContractState,
            ) -> @world_provider_cpt::ComponentState<ContractState> {
                @world_provider_cpt::unsafe_new_component_state::<ContractState>()
            }
            fn get_component_mut(
                ref self: ContractState,
            ) -> world_provider_cpt::ComponentState<ContractState> {
                world_provider_cpt::unsafe_new_component_state::<ContractState>()
            }
            fn get_contract(
                self: @world_provider_cpt::ComponentState<ContractState>,
            ) -> @ContractState {
                @unsafe_new_contract_state()
            }
            fn get_contract_mut(
                ref self: world_provider_cpt::ComponentState<ContractState>,
            ) -> ContractState {
                unsafe_new_contract_state()
            }
            fn emit<S, impl IntoImp: core::traits::Into<S, world_provider_cpt::Event>>(
                ref self: world_provider_cpt::ComponentState<ContractState>, event: S,
            ) {
                let event: world_provider_cpt::Event = core::traits::Into::into(event);
                let mut contract = world_provider_cpt::HasComponent::get_contract_mut(ref self);
                ContractStateEventEmitter::emit(ref contract, Event::WorldProviderEvent(event));
            }
        }
        impl HasComponentImpl_upgradeable_cpt of upgradeable_cpt::HasComponent<ContractState> {
            fn get_component(
                self: @ContractState,
            ) -> @upgradeable_cpt::ComponentState<ContractState> {
                @upgradeable_cpt::unsafe_new_component_state::<ContractState>()
            }
            fn get_component_mut(
                ref self: ContractState,
            ) -> upgradeable_cpt::ComponentState<ContractState> {
                upgradeable_cpt::unsafe_new_component_state::<ContractState>()
            }
            fn get_contract(
                self: @upgradeable_cpt::ComponentState<ContractState>,
            ) -> @ContractState {
                @unsafe_new_contract_state()
            }
            fn get_contract_mut(
                ref self: upgradeable_cpt::ComponentState<ContractState>,
            ) -> ContractState {
                unsafe_new_contract_state()
            }
            fn emit<S, impl IntoImp: core::traits::Into<S, upgradeable_cpt::Event>>(
                ref self: upgradeable_cpt::ComponentState<ContractState>, event: S,
            ) {
                let event: upgradeable_cpt::Event = core::traits::Into::into(event);
                let mut contract = upgradeable_cpt::HasComponent::get_contract_mut(ref self);
                ContractStateEventEmitter::emit(ref contract, Event::UpgradeableEvent(event));
            }
        }
        #[doc(hidden)]
        impl StorageStorageBaseDrop<> of core::traits::Drop<StorageStorageBase>;
        #[doc(hidden)]
        impl StorageStorageBaseCopy<> of core::traits::Copy<StorageStorageBase>;
        #[doc(hidden)]
        impl StorageStorageBaseMutDrop<> of core::traits::Drop<StorageStorageBaseMut>;
        #[doc(hidden)]
        impl StorageStorageBaseMutCopy<> of core::traits::Copy<StorageStorageBaseMut>;

        mod __external {
            use super::{
                __wrapper__DojoDeployedContractImpl__dojo_name as dojo_name,
                __wrapper__IDojoInitImpl__dojo_init as dojo_init,
            };
        }

        mod __l1_handler {}

        mod __constructor {
            use super::__wrapper__constructor as constructor;
        }
    }
}
