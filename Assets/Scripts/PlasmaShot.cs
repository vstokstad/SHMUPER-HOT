using UnityEngine;
using static WeaponManager;


public class PlasmaShot : MonoBehaviour, IWeapon {
    private readonly string enemyTag = "Enemy";
    private readonly float plasmaDamage = 1f;
    private ParticleSystem _particleSystem;

    private GameObject _plasmaShot;
    private Vector3 _plasmaVelocity;
    private PlayerController _playerController;
    private PlayerData _playerData;
    private float _shootTimer = 0.2f;

    private void Awake(){
        _particleSystem = GetComponent<ParticleSystem>();
        _playerController = GetComponent<PlayerController>();
        _playerData = _playerController.playerData;
    }

    private void OnEnable(){
        _particleSystem.Play();
    }

    private void OnTriggerEnter(Collider other){
        if (!other.gameObject.CompareTag(enemyTag)) return;
        other.gameObject.GetComponent<EnemyController>().TakeDamage(plasmaDamage);
        WeaponPool.Instance.ReturnToPool(gameObject);
    }


    public void Shoot(){
        if (!(_shootTimer <= 0f)) {
            _shootTimer -= Time.unscaledDeltaTime;
            return;
        }

        _shootTimer = 0.2f;

        _plasmaShot = WeaponPool.Instance.Get(WeaponType.Plasma);

        Vector3 initialPosition = _playerController.gameObject.transform.position;
        initialPosition.x += 1f;
        _plasmaShot.transform.position = initialPosition;
        _plasmaShot.SetActive(true);
        _plasmaVelocity.x = 20f;
        _plasmaVelocity.y = Mathf.Tan(initialPosition.y * Time.fixedUnscaledDeltaTime);
        _plasmaShot.GetComponent<Rigidbody>().velocity = _plasmaVelocity;
    }
}